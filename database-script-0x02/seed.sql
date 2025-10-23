-- seed.sql
-- Sample data for ALX Airbnb Database (SQLite)
-- Run: sqlite3 alx_airbnb.db < database-script-0x02/seed.sql

PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

-- =========================
-- Users
-- =========================
INSERT INTO app_user (id, first_name, last_name, email, password_hash, phone, is_host, created_at, updated_at) VALUES
  (1, 'Alice', 'Kim', 'alice.kim@example.com', 'hashed_pw_1', '+254700000001', 1, datetime('2025-10-01'), datetime('2025-10-01')),
  (2, 'Brian', 'Otieno', 'brian.otieno@example.com', 'hashed_pw_2', '+254700000002', 1, datetime('2025-09-20'), datetime('2025-09-20')),
  (3, 'Cynthia', 'Mwangi', 'cynthia.mwangi@example.com', 'hashed_pw_3', '+254700000003', 0, datetime('2025-08-15'), datetime('2025-08-15')),
  (4, 'Daniel', 'Maina', 'daniel.maina@example.com', 'hashed_pw_4', '+254700000004', 0, datetime('2025-07-04'), datetime('2025-07-04')),
  (5, 'Eva', 'Ndegwa', 'eva.ndegwa@example.com', 'hashed_pw_5', '+254700000005', 1, datetime('2025-06-10'), datetime('2025-06-10')),
  (6, 'Frank', 'Karanja', 'frank.karanja@example.com', 'hashed_pw_6', '+254700000006', 0, datetime('2025-05-03'), datetime('2025-05-03'));

-- =========================
-- Host profiles (for users who are hosts)
-- =========================
INSERT INTO host_profile (user_id, payout_account_info, verification_status, host_bio, created_at, updated_at) VALUES
  (1, 'mpesa_token_abc123', 'verified', 'Experienced host in Nairobi; tidy 2-bed apartments.', datetime('2025-10-01'), datetime('2025-10-01')),
  (2, 'bank_token_xyz789', 'verified', 'Host of holiday villas on the coast.', datetime('2025-09-20'), datetime('2025-09-20')),
  (5, 'mpesa_token_eva555', 'pending', 'New host offering lake retreats.', datetime('2025-06-10'), datetime('2025-06-10'));

-- =========================
-- Locations
-- =========================
INSERT INTO location (id, street_address, neighborhood, city, state_or_region, country, postal_code, latitude, longitude) VALUES
  (1, '1 Riverside Ave', 'Central Business District', 'Nairobi', 'Nairobi County', 'Kenya', '00100', -1.28333, 36.81667),
  (2, '12 Ocean Drive', 'Diani Beach', 'Mombasa', 'Mombasa County', 'Kenya', '80100', -4.04348, 39.66821),
  (3, '45 Lake Road', 'Kisumu Lakeside', 'Kisumu', 'Kisumu County', 'Kenya', '40100', -0.09170, 34.76796');

-- =========================
-- Properties
-- =========================
INSERT INTO property (id, owner_id, location_id, title, description, price_per_night, max_guests, num_bedrooms, num_beds, num_baths, created_at, updated_at) VALUES
  (1, 1, 1, 'Cozy 2BR Apartment — Nairobi CBD', 'Bright 2-bedroom apartment near restaurants and transport.', 65.00, 4, 2, 2, 1.5, datetime('2025-09-01'), datetime('2025-09-01')),
  (2, 2, 2, 'Beachfront Villa — Mombasa', 'Private villa with sea views, pool, and chef service on request.', 200.00, 8, 4, 5, 3.0, datetime('2025-08-15'), datetime('2025-08-15')),
  (3, 1, 1, 'Studio Downtown — Nairobi', 'Compact studio for solo travelers, close to nightlife.', 40.00, 2, 0, 1, 1.0, datetime('2025-09-10'), datetime('2025-09-10')),
  (4, 5, 3, 'Lakeside House — Kisumu', 'Spacious house with lake access and boat dock.', 150.00, 6, 3, 4, 2.5, datetime('2025-06-20'), datetime('2025-06-20'));

-- =========================
-- Photos
-- =========================
INSERT INTO photo (id, property_id, url, caption, sort_order, created_at) VALUES
  (1, 1, 'https://example.com/photos/prop1-1.jpg', 'Living room with balcony', 1, datetime('2025-09-01')),
  (2, 1, 'https://example.com/photos/prop1-2.jpg', 'Kitchen area', 2, datetime('2025-09-01')),
  (3, 2, 'https://example.com/photos/prop2-1.jpg', 'Villa facade and pool', 1, datetime('2025-08-15')),
  (4, 2, 'https://example.com/photos/prop2-2.jpg', 'Ocean view terrace', 2, datetime('2025-08-15')),
  (5, 3, 'https://example.com/photos/prop3-1.jpg', 'Cozy studio interior', 1, datetime('2025-09-10')),
  (6, 4, 'https://example.com/photos/prop4-1.jpg', 'Lakeside patio', 1, datetime('2025-06-20'));

-- =========================
-- Amenities
-- =========================
INSERT INTO amenity (id, name) VALUES
  (1, 'Wi-Fi'),
  (2, 'Pool'),
  (3, 'Kitchen'),
  (4, 'Free parking'),
  (5, 'Air conditioning'),
  (6, 'Boat dock');

-- =========================
-- Property - Amenity (join table)
-- =========================
INSERT INTO property_amenity (property_id, amenity_id, added_at) VALUES
  (1, 1, datetime('2025-09-01')),
  (1, 3, datetime('2025-09-01')),
  (1, 5, datetime('2025-09-01')),
  (2, 1, datetime('2025-08-15')),
  (2, 2, datetime('2025-08-15')),
  (2, 3, datetime('2025-08-15')),
  (2, 5, datetime('2025-08-15')),
  (3, 1, datetime('2025-09-10')),
  (3, 3, datetime('2025-09-10')),
  (4, 1, datetime('2025-06-20')),
  (4, 4, datetime('2025-06-20')),
  (4, 6, datetime('2025-06-20'));

-- =========================
-- Bookings
-- Note: total_price stored as snapshot (price_per_night * nights + simple cleaning/fees)
-- =========================
INSERT INTO booking (id, user_id, property_id, start_date, end_date, total_price, status, created_at, updated_at) VALUES
  (1, 4, 1, '2025-10-10', '2025-10-12', 65.00 * 2 + 10.00, 'confirmed', datetime('2025-09-15'), datetime('2025-09-15')),
  (2, 3, 2, '2025-11-01', '2025-11-05', 200.00 * 4 + 50.00, 'pending', datetime('2025-09-20'), datetime('2025-09-20')),
  (3, 6, 3, '2025-09-20', '2025-09-22', 40.00 * 2 + 5.00, 'completed', datetime('2025-09-11'), datetime('2025-09-22')),
  (4, 4, 4, '2025-12-24', '2025-12-27', 150.00 * 3 + 25.00, 'confirmed', datetime('2025-10-02'), datetime('2025-10-02'));

-- =========================
-- Payments
-- =========================
INSERT INTO payment (id, booking_id, amount, currency, method, status, paid_at, created_at, updated_at) VALUES
  (1, 1, (65.00 * 2 + 10.00), 'KES', 'mpesa', 'paid', datetime('2025-09-15'), datetime('2025-09-15'), datetime('2025-09-15')),
  (2, 2, 0.00, 'USD', 'card', 'pending', NULL, datetime('2025-09-20'), datetime('2025-09-20')), -- unpaid yet
  (3, 3, (40.00 * 2 + 5.00), 'USD', 'card', 'paid', datetime('2025-09-12'), datetime('2025-09-12'), datetime('2025-09-12')),
  (4, 4, (150.00 * 3 + 25.00), 'KES', 'mpesa', 'paid', datetime('2025-10-03'), datetime('2025-10-03'), datetime('2025-10-03'));

-- =========================
-- Reviews
-- =========================
INSERT INTO review (id, user_id, property_id, rating, comment, created_at) VALUES
  (1, 4, 1, 5, 'Wonderful stay — clean and close to everything.', datetime('2025-10-13')),
  (2, 3, 2, 4, 'Amazing location and service; a bit pricey.', datetime('2025-11-06')),
  (3, 6, 3, 5, 'Perfect for a quick trip; cozy and quiet.', datetime('2025-09-23'));

COMMIT;
