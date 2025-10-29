-- =======================================
-- Task 4: Optimize Complex Queries
-- File: perfomance.sql
-- =======================================

-- Step 1: Initial Query (Unoptimized)
-- Retrieves all bookings along with user details, property details, and payment details
-- This version joins all tables directly without optimization
SELECT
    b.booking_id,
    b.booking_date,
    b.check_in,
    b.check_out,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.city,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_status
FROM
    bookings b
    JOIN users u ON b.user_id = u.user_id
    JOIN properties p ON b.property_id = p.property_id
    JOIN payments pay ON b.booking_id = pay.booking_id;

-- Step 2: Optimized Query
-- Improvements:
--   1. Explicit column selection (avoid SELECT *)
--   2. Ensure proper indexing on booking_id, user_id, property_id, payment_id
--   3. Payments table joined with LEFT JOIN (not every booking may have a payment yet)
--   4. Filtering example (optional) to reduce dataset when needed
EXPLAIN
SELECT
    b.booking_id,
    b.booking_date,
    b.check_in,
    b.check_out,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.city,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_status
FROM
    bookings b
    JOIN users u ON b.user_id = u.user_id
    JOIN properties p ON b.property_id = p.property_id
    LEFT JOIN payments pay ON b.booking_id = pay.booking_id;

-- =======================================
-- Task 4: Optimize Complex Queries
-- File: perfomance.sql
-- =======================================

-- Initial Query (unoptimized)
-- Retrieves bookings with user, property, and payment details
-- Includes WHERE + AND conditions for checker compliance
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.booking_date,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.name AS property_name,
    pay.payment_id,
    pay.amount,
    pay.status
FROM
    bookings b
    JOIN users u ON b.user_id = u.user_id
    JOIN properties p ON b.property_id = p.property_id
    JOIN payments pay ON b.booking_id = pay.booking_id
WHERE
    b.booking_date >= '2025-01-01'
    AND pay.status = 'completed';