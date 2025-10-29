-- =======================================
-- Task 5: Partitioning Large Tables
-- File: partitioning.sql
-- =======================================

-- 1. Drop existing Booking table if it exists (for testing only)
DROP TABLE IF EXISTS bookings CASCADE;

-- 2. Create a new parent Booking table partitioned by RANGE on start_date
CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY,
    user_id UUID,
    property_id UUID,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
)
PARTITION BY
    RANGE (start_date);

-- 3. Create partitions (example: yearly partitions)
CREATE TABLE bookings_2024 PARTITION OF bookings FOR
VALUES
FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings FOR
VALUES
FROM ('2025-01-01') TO ('2026-01-01');

-- 4. Example query to test partition performance
-- Fetch bookings in a date range
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE
    start_date BETWEEN '2025-01-01' AND '2025-06-30';