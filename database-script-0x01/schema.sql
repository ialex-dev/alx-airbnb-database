-- schema.sql
-- ALX Airbnb Database schema (SQLite 3)
-- Compatible with: SQLite 3.35+ (used in Python, Node.js, etc.)

PRAGMA foreign_keys = ON;

-- ========== Users ==========
CREATE TABLE IF NOT EXISTS app_user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT,
    last_name TEXT,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    phone TEXT,
    is_host INTEGER DEFAULT 0, -- 0 = false, 1 = true
    created_at TEXT DEFAULT(datetime('now')),
    updated_at TEXT DEFAULT(datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_app_user_email ON app_user (email);

-- ========== Host profile (1:1 optional) ==========
CREATE TABLE IF NOT EXISTS host_profile (
    user_id INTEGER PRIMARY KEY,
    payout_account_info TEXT,
    verification_status TEXT,
    host_bio TEXT,
    created_at TEXT DEFAULT(datetime('now')),
    updated_at TEXT DEFAULT(datetime('now')),
    FOREIGN KEY (user_id) REFERENCES app_user (id) ON DELETE CASCADE
);

-- ========== Location ==========
CREATE TABLE IF NOT EXISTS location (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    street_address TEXT,
    neighborhood TEXT,
    city TEXT NOT NULL,
    state_or_region TEXT,
    country TEXT NOT NULL,
    postal_code TEXT,
    latitude REAL,
    longitude REAL
);

CREATE INDEX IF NOT EXISTS idx_location_city ON location (city);

CREATE INDEX IF NOT EXISTS idx_location_country ON location (country);

-- ========== Property ==========
CREATE TABLE IF NOT EXISTS property (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    owner_id INTEGER NOT NULL,
    location_id INTEGER,
    title TEXT,
    description TEXT,
    price_per_night REAL NOT NULL CHECK (price_per_night >= 0),
    max_guests INTEGER CHECK (max_guests >= 1),
    num_bedrooms INTEGER CHECK (num_bedrooms >= 0),
    num_beds INTEGER CHECK (num_beds >= 0),
    num_baths REAL CHECK (num_baths >= 0),
    created_at TEXT DEFAULT(datetime('now')),
    updated_at TEXT DEFAULT(datetime('now')),
    FOREIGN KEY (owner_id) REFERENCES app_user (id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES location (id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_property_owner ON property (owner_id);

CREATE INDEX IF NOT EXISTS idx_property_price ON property (price_per_night);

-- ========== Booking ==========
CREATE TABLE IF NOT EXISTS booking (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    start_date TEXT NOT NULL,
    end_date TEXT NOT NULL,
    total_price REAL CHECK (total_price >= 0),
    status TEXT NOT NULL DEFAULT 'pending',
    created_at TEXT DEFAULT(datetime('now')),
    updated_at TEXT DEFAULT(datetime('now')),
    FOREIGN KEY (user_id) REFERENCES app_user (id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES property (id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_booking_user ON booking (user_id);

CREATE INDEX IF NOT EXISTS idx_booking_property_dates ON booking (
    property_id,
    start_date,
    end_date
);

-- ========== Payment ==========
CREATE TABLE IF NOT EXISTS payment (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    booking_id INTEGER NOT NULL,
    amount REAL NOT NULL CHECK (amount >= 0),
    currency TEXT DEFAULT 'USD',
    method TEXT,
    status TEXT DEFAULT 'pending',
    paid_at TEXT,
    created_at TEXT DEFAULT(datetime('now')),
    updated_at TEXT DEFAULT(datetime('now')),
    FOREIGN KEY (booking_id) REFERENCES booking (id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_payment_booking ON payment (booking_id);

CREATE INDEX IF NOT EXISTS idx_payment_status ON payment (status);

-- ========== Review ==========
CREATE TABLE IF NOT EXISTS review (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TEXT DEFAULT(datetime('now')),
    FOREIGN KEY (user_id) REFERENCES app_user (id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES property (id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_review_user ON review (user_id);

CREATE INDEX IF NOT EXISTS idx_review_property ON review (property_id);

-- ========== Amenity ==========
CREATE TABLE IF NOT EXISTS amenity (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

-- ========== Property-Amenity (many-to-many) ==========
CREATE TABLE IF NOT EXISTS property_amenity (
    property_id INTEGER NOT NULL,
    amenity_id INTEGER NOT NULL,
    added_at TEXT DEFAULT(datetime('now')),
    PRIMARY KEY (property_id, amenity_id),
    FOREIGN KEY (property_id) REFERENCES property (id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES amenity (id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_property_amenity_property ON property_amenity (property_id);

CREATE INDEX IF NOT EXISTS idx_property_amenity_amenity ON property_amenity (amenity_id);

-- ========== Photo ==========
CREATE TABLE IF NOT EXISTS photo (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    property_id INTEGER NOT NULL,
    url TEXT NOT NULL,
    caption TEXT,
    sort_order INTEGER,
    created_at TEXT DEFAULT(datetime('now')),
    FOREIGN KEY (property_id) REFERENCES property (id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_photo_property ON photo (property_id);