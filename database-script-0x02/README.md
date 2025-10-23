# Seed Data — ALX Airbnb Database

## Purpose
This directory contains `seed.sql`, a set of sample INSERT statements to populate the SQLite database with realistic test data (users, hosts, properties, bookings, payments, reviews, amenities, photos).

## Files
- `seed.sql` — SQL script that inserts sample rows into the schema created by `database-script-0x01/schema.sql`.

## How to run (SQLite)

1. Ensure the schema exists (run the schema script first):

   ```bash
   sqlite3 alx_airbnb.db < ../database-script-0x01/schema.sql
