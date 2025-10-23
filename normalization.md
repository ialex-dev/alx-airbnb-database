# Database Normalization — ALX Airbnb Database (3NF)

## 🎯 Objective

Apply normalization principles to ensure the ALX Airbnb database schema is in **Third Normal Form (3NF)**.  
This document outlines the normalization process, identifies potential redundancies, and presents the final normalized schema design.

---

## 🧩 1. Purpose of Normalization

Normalization organizes database tables to reduce redundancy and improve data integrity.  
For the **ALX Airbnb Database**, normalization ensures that:

- Each attribute is stored in the correct table.
- There are no duplicated or repeating fields.
- Relationships are efficiently defined through primary and foreign keys.

---

## 🧱 2. Normalization Stages Overview

### **First Normal Form (1NF)**

- All table fields contain **atomic (indivisible)** values.
- No repeating groups or arrays.
- Each record is uniquely identified by a **primary key**.

✅ *Example applied:*  
Each `User` record has a single email and ID — no multiple emails in one field.

---

### **Second Normal Form (2NF)**

- Must already be in 1NF.
- All **non-key attributes** depend on the **whole primary key**, not just part of it.
- Mainly applies to tables with **composite keys**.

✅ *Example applied:*  
In `property_amenity`, the composite key (`property_id`, `amenity_id`) ensures that every non-key attribute (if any) depends on both keys together.

---

### **Third Normal Form (3NF)**

- Must already be in 2NF.
- **No transitive dependencies** — non-key attributes cannot depend on other non-key attributes.
- Each field describes only the entity identified by its key.

✅ *Example applied:*  
In the `Property` table, we store only `owner_id` (FK → `User.id`) — not owner name or email — eliminating transitive dependency on `User`.

---

## 🔍 3. Identified Issues and Fixes

| Issue | Problem | Normalization Step | Resolution |
|-------|----------|--------------------|-------------|
| Repeated city/country info in `Property` | Redundant text fields | 3NF | Moved into optional `Location` table |
| Host-specific attributes in `User` | Many nullable fields | 3NF | Moved to `HostProfile` table |
| Derived `total_price` in `Booking` | Could cause inconsistency | 2NF/3NF | Keep as computed or store as immutable audit field |
| Amenity relationships | Multi-valued field | 1NF | Split into `Amenity` + `property_amenity` join table |

---

## 🧮 4. Final Normalized Schema (3NF)

### **User**

- `id` (PK)  
- `first_name`  
- `last_name`  
- `email` (UNIQUE)  
- `password_hash`  
- `phone` (nullable)  
- `is_host`  
- `created_at`  
- `updated_at`

---

### **HostProfile**

- `user_id` (PK, FK → User.id)  
- `payout_account_info`  
- `verification_status`  
- `host_bio`  
- `created_at`, `updated_at`

---

### **Location**

- `id` (PK)  
- `street_address`, `city`, `country`, `latitude`, `longitude`

---

### **Property**

- `id` (PK)  
- `owner_id` (FK → User.id)  
- `location_id` (FK → Location.id)  
- `title`, `description`, `price_per_night`  
- `max_guests`, `num_bedrooms`, `num_beds`, `num_baths`  
- `created_at`, `updated_at`

---

### **Booking**

- `id` (PK)  
- `user_id` (FK → User.id)  
- `property_id` (FK → Property.id)  
- `start_date`, `end_date`, `status`  
- `total_price` *(optional snapshot)*  
- `created_at`, `updated_at`

---

### **Payment**

- `id` (PK)  
- `booking_id` (FK → Booking.id)  
- `amount`, `currency`, `method`, `status`  
- `paid_at`, `created_at`

---

### **Review**

- `id` (PK)  
- `user_id` (FK → User.id)  
- `property_id` (FK → Property.id)  
- `rating`, `comment`, `created_at`

---

### **Amenity**

- `id` (PK)  
- `name` (UNIQUE)

---

### **property_amenity**

- `property_id` (FK → Property.id)  
- `amenity_id` (FK → Amenity.id)  
- **Primary Key:** (`property_id`, `amenity_id`)

---

### **Photo**

- `id` (PK)  
- `property_id` (FK → Property.id)  
- `url`, `caption`, `sort_order`, `created_at`

---

## ✅ 5. Verification Checklist for 3NF

- [x] All columns hold atomic values (1NF).  
- [x] All non-key columns depend on the whole key (2NF).  
- [x] No transitive dependencies exist (3NF).  
- [x] Many-to-many relationships handled via join tables.  
- [x] No repeated data fields across tables.  
- [x] Derived or computed values stored only when necessary for historical reasons.  

---

## ⚙️ 6. Example (PostgreSQL-style) SQL Snippet

```sql
CREATE TABLE app_user (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  phone VARCHAR(50),
  is_host BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE property (
  id SERIAL PRIMARY KEY,
  owner_id INT NOT NULL REFERENCES app_user(id),
  title VARCHAR(255),
  description TEXT,
  price_per_night DECIMAL(10,2),
  max_guests INT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE booking (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES app_user(id),
  property_id INT NOT NULL REFERENCES property(id),
  start_date DATE,
  end_date DATE,
  total_price DECIMAL(10,2),
  status VARCHAR(20),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

```

## 🧠 7. Summary

After normalization:

- Redundancy and duplication are eliminated.  
- Each table represents a single entity or relationship.  
- The schema is clean, maintainable, and scalable for production systems.  
- The final database structure fully complies with **Third Normal Form (3NF)**.
