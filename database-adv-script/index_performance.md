# Task 3: Implement Indexes for Optimization

## 🎯 Objective

Indexes are used to speed up data retrieval in frequently queried columns.  
We identified common **WHERE**, **JOIN**, and **ORDER BY** patterns in the Airbnb schema and applied indexes accordingly.  

---

## 🔑 Indexes Created

### Users Table

```sql
CREATE INDEX idx_users_email ON users(email);

CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_date ON bookings(booking_date);

CREATE INDEX idx_properties_city ON properties(city);
CREATE INDEX idx_properties_city_price ON properties(city, price_per_night);
