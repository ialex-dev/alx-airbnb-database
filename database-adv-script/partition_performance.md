# Partitioning Performance Report

## Objective

We partitioned the `bookings` table by **start_date** to optimize queries on large datasets.

## Implementation

- Created a parent table `bookings` partitioned by RANGE on `start_date`.
- Added partitions:
  - `bookings_2024` for dates in 2024
  - `bookings_2025` for dates in 2025

## Performance Comparison

### Before Partitioning

Query:

```sql
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2025-01-01' AND '2025-06-30';
```

EXPLAIN ANALYZE
SELECT \* FROM bookings
WHERE start_date BETWEEN '2025-01-01' AND '2025-06-30';
