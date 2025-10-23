# Entity Relationship Diagram (ERD) — ALX Airbnb Database

## Objective
Design a relational database schema for the ALX Airbnb Clone project that defines all entities, their attributes, and relationships.  
This ERD will serve as the foundation for the project backend and data storage layer.

---

## Entities and Attributes

### 🧍‍♂️ `User`
| Field | Type | Description |
|--------|------|-------------|
| `id` | INT (PK) | Unique user identifier |
| `first_name` | VARCHAR | User's first name |
| `last_name` | VARCHAR | User's last name |
| `email` | VARCHAR (UNIQUE) | User's email address |
| `password_hash` | VARCHAR | Hashed password |
| `phone` | VARCHAR (nullable) | User phone number |
| `is_host` | BOOLEAN | Whether the user is a host |
| `created_at` | TIMESTAMP | Record creation date |
| `updated_at` | TIMESTAMP | Last update date |

---

### 🏠 `Property` (Place)
| Field | Type | Description |
|--------|------|-------------|
| `id` | INT (PK) | Unique property ID |
| `owner_id` | INT (FK → User.id) | Property owner |
| `title` | VARCHAR | Listing title |
| `description` | TEXT | Description of the property |
| `price_per_night` | DECIMAL(10,2) | Price per night |
| `city` | VARCHAR | City name |
| `country` | VARCHAR | Country name |
| `address` | VARCHAR | Full address |
| `max_guests` | INT | Max number of guests |
| `num_bedrooms` | INT | Number of bedrooms |
| `num_beds` | INT | Number of beds |
| `num_baths` | DECIMAL(3,1) | Number of bathrooms |
| `created_at` | TIMESTAMP | Creation timestamp |
| `updated_at` | TIMESTAMP | Update timestamp |

---

### 🧾 `Booking`
| Field | Type | Description |
|--------|------|-------------|
| `id` | INT (PK) | Booking ID |
| `user_id` | INT (FK → User.id) | Guest who booked |
| `property_id` | INT (FK → Property.id) | Property booked |
| `start_date` | DATE | Check-in date |
| `end_date` | DATE | Check-out date |
| `total_price` | DECIMAL(10,2) | Total booking cost |
| `status` | ENUM('pending','confirmed','cancelled','completed') | Booking status |
| `created_at` | TIMESTAMP | Date created |
| `updated_at` | TIMESTAMP | Last update |

---

### ⭐ `Review`
| Field | Type | Description |
|--------|------|-------------|
| `id` | INT (PK) | Review ID |
| `user_id` | INT (FK → User.id) | Reviewer |
| `property_id` | INT (FK → Property.id) | Reviewed property |
| `rating` | INT (1–5) | Star rating |
| `comment` | TEXT | Review text |
| `created_at` | TIMESTAMP | Review date |

---

### 🧩 `Amenity`
| Field | Type | Description |
|--------|------|-------------|
| `id` | INT (PK) | Amenity ID |
| `name` | VARCHAR | Amenity name (e.g., Wi-Fi, Pool) |

---

### 🔗 `property_amenity` (Join Table)
| Field | Type | Description |
|--------|------|-------------|
| `property_id` | INT (FK → Property.id, PK) | Related property |
| `amenity_id` | INT (FK → Amenity.id, PK) | Related amenity |

---

### 🖼️ `Photo`
| Field | Type | Description |
|--------|------|-------------|
| `id` | INT (PK) | Photo ID |
| `property_id` | INT (FK → Property.id) | Linked property |
| `url` | VARCHAR | Image URL |
| `caption` | VARCHAR (nullable) | Optional caption |
| `sort_order` | INT (nullable) | Display order |

---

### 💳 `Payment`
| Field | Type | Description |
|--------|------|-------------|
| `id` | INT (PK) | Payment ID |
| `booking_id` | INT (FK → Booking.id) | Related booking |
| `amount` | DECIMAL(10,2) | Amount paid |
| `currency` | VARCHAR | Payment currency |
| `method` | VARCHAR | Payment method (e.g., mpesa, card) |
| `status` | ENUM('pending','paid','refunded') | Payment status |
| `paid_at` | TIMESTAMP (nullable) | Payment timestamp |

---

## Relationships Summary

| Relationship | Type | Description |
|---------------|------|-------------|
| User → Property | One-to-Many | A host can own multiple properties |
| User → Booking | One-to-Many | A guest can make multiple bookings |
| User → Review | One-to-Many | A user can post multiple reviews |
| Property → Booking | One-to-Many | A property can have many bookings |
| Property → Review | One-to-Many | A property can have many reviews |
| Property → Photo | One-to-Many | A property can have multiple photos |
| Property ↔ Amenity | Many-to-Many | Properties can have multiple amenities |
| Booking → Payment | One-to-One / One-to-Many | Each booking has one or more payments |

---