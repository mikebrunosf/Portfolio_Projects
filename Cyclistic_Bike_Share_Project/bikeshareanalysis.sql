-- Cyclistic Case Study
--  Descriptive Analysis
-- Author: Michael Bruno
-- Date: 2025-09-10
-- Purpose: Compare member vs casual behavior

-- find average ride duration for members and casual users
SELECT member_casual, AVG(ride_length_minutes) AS avg_length
FROM all_trips_clean
GROUP BY member_casual;

-- Median ride length
SELECT member_casual, 
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ride_length_minutes) 
       OVER (PARTITION BY member_casual) AS median_ride_length
FROM all_trips_clean;

-- Ride counts by day of week
SELECT member_casual, day_of_week, COUNT(*) AS ride_count
FROM all_trips_clean
GROUP BY member_casual, day_of_week
ORDER BY member_casual, ride_count DESC;

-- Monthly ride counts
-- NOTE: September 2024 dataset includes one day of August (2024-08-31).
-- This explains the unusually low ride counts for August 2024 (~388 rides).
-- Decided to keep as-is since it does not affect long-term trends.
SELECT member_casual, FORMAT(started_at, 'yyyy-MM') AS month, COUNT(*) AS ride_count
FROM all_trips_clean
GROUP BY member_casual, FORMAT(started_at, 'yyyy-MM')
ORDER BY month, member_casual;

-- Ride counts by hour
SELECT member_casual, DATEPART(HOUR, started_at) AS hour_of_day, COUNT(*) AS ride_count
FROM all_trips_clean
GROUP BY member_casual, DATEPART(HOUR, started_at)
ORDER BY hour_of_day, member_casual;

-- Bike type breakdown by member type and overall
-- Breakdown by member type
SELECT member_casual, rideable_type, COUNT(*) AS ride_count
FROM all_trips_clean
GROUP BY member_casual, rideable_type

UNION ALL

-- Total per bike type (member + casual combined)
SELECT 'Total' AS member_casual, rideable_type, COUNT(*) AS ride_count
FROM all_trips_clean
GROUP BY rideable_type
ORDER BY rideable_type, member_casual;


