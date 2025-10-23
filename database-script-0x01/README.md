# Database Schema (DDL) — ALX Airbnb Database

Location: `database-script-0x01/`

## Files

- `schema.sql` — PostgreSQL DDL to create the database schema (tables, constraints, indexes).
- `README.md` — this file.

## Purpose

This script defines the normalized database schema used by the ALX Airbnb clone:
`app_user`, `host_profile`, `location`, `property`, `booking`, `payment`, `review`, `amenity`, `property_amenity`, and `photo`.

The schema is designed to be in 3NF, with sensible constraints and indexes for common queries.

## DB engine

The provided `schema.sql` targets **PostgreSQL**. Notes:

- `SERIAL` is used for primary keys for simplicity. If you prefer **UUID** primary keys, replace `SERIAL` with `UUID` types and add UUID generation (e.g., `uuid-ossp` extension).
- If you use **MySQL** or **SQLite**, adapt the types and timestamp defaults accordingly.

## 🧩 How to Run (SQLite)

1. **Create the database and load the schema:**

   ```bash
   sqlite3 alx_airbnb.db < database-script-0x01/schema.sql

2. **Check existing tables:**

    ```bash
    sqlite3 alx_airbnb.db
    sqlite> .tables
    ```
3. **View the schema of a specific table (e.g., booking):**

    ```bash
    sqlite> .schema booking
