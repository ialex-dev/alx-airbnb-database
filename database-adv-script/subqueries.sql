-- ================================
-- Task 1: Practice Subqueries
-- File: subqueries.sql
-- ================================

-- 1. Non-Correlated Subquery
-- Find all properties where the average rating is greater than 4.0
SELECT
    p.id AS property_id,
    p.name AS property_name,
    (
        SELECT AVG(r.rating)
        FROM reviews r
        WHERE
            r.property_id = p.id
    ) AS avg_rating
FROM properties p
WHERE (
        SELECT AVG(r.rating)
        FROM reviews r
        WHERE
            r.property_id = p.id
    ) > 4.0
ORDER BY p.id;

-- 2. Correlated Subquery
-- Find users who have made more than 3 bookings
SELECT
    u.id AS user_id,
    u.name AS user_name,
    (
        SELECT COUNT(*)
        FROM bookings b
        WHERE
            b.user_id = u.id
    ) AS total_bookings
FROM users u
WHERE (
        SELECT COUNT(*)
        FROM bookings b
        WHERE
            b.user_id = u.id
    ) > 3
ORDER BY u.id;