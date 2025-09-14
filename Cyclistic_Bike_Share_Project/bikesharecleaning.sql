-- Cyclistic Case Study
-- Data Cleaning
-- Author: Michael Bruno
-- Date: 2025-09-08
-- Purpose: Compare member vs casual behavior
/*
--Union all monthly tables from last 12 months

WITH all_trips AS (
SELECT *
FROM [Cyclistic]..[202409-divvy-tripdata]
UNION ALL
SELECT *
FROM [Cyclistic]..[202410-divvy-tripdata]
UNION ALL
SELECT *
FROM [Cyclistic]..[202411-divvy-tripdata]
UNION ALL
SELECT *
FROM [Cyclistic]..[202412-divvy-tripdata]
UNION ALL
SELECT *
FROM [Cyclistic]..[202501-divvy-tripdata]
UNION ALL
SELECT *
FROM [Cyclistic]..[202502-divvy-tripdata]
UNION ALL
SELECT *
FROM [Cyclistic]..[202503-divvy-tripdata]
UNION ALL
SELECT *
FROM [Cyclistic]..[202504-divvy-tripdata]
UNION ALL
SELECT *
FROM [Cyclistic]..[202505-divvy-tripdata]
UNION ALL
SELECT *
FROM [Cyclistic]..[202506-divvy-tripdata]
UNION ALL
SELECT *
FROM [Cyclistic]..[202507-divvy-tripdata]
UNION ALL
SELECT *
FROM [Cyclistic]..[202508-divvy-tripdata]
)

-- Find ride duration and day of week ride occured
SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    DATEDIFF(MINUTE, started_at, ended_at) AS ride_length_minutes,
    DATENAME(WEEKDAY, started_at) AS day_of_week,
    member_casual
FROM all_trips;

--alter query for cleaning up results

SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    DATEDIFF(MINUTE, started_at, ended_at) AS ride_length_minutes,
    DATENAME(WEEKDAY, started_at) AS day_of_week,
    member_casual
FROM all_trips
WHERE
    started_at < ended_at
    AND DATEDIFF(MINUTE, started_at, ended_at) > 0   -- remove zero/negative
    AND DATEDIFF(HOUR, started_at, ended_at) < 24;   -- remove extreme outliers
	*/

--CREATE VIEW

CREATE VIEW all_trips_clean AS
WITH all_trips AS (
    SELECT * FROM [Cyclistic]..[202409-divvy-tripdata]
    UNION ALL
    SELECT * FROM [Cyclistic]..[202410-divvy-tripdata]
    UNION ALL
    SELECT * FROM [Cyclistic]..[202411-divvy-tripdata]
    UNION ALL
    SELECT * FROM [Cyclistic]..[202412-divvy-tripdata]
    UNION ALL
    SELECT * FROM [Cyclistic]..[202501-divvy-tripdata]
    UNION ALL
    SELECT * FROM [Cyclistic]..[202502-divvy-tripdata]
    UNION ALL
    SELECT * FROM [Cyclistic]..[202503-divvy-tripdata]
    UNION ALL
    SELECT * FROM [Cyclistic]..[202504-divvy-tripdata]
    UNION ALL
    SELECT * FROM [Cyclistic]..[202505-divvy-tripdata]
    UNION ALL
    SELECT * FROM [Cyclistic]..[202506-divvy-tripdata]
    UNION ALL
    SELECT * FROM [Cyclistic]..[202507-divvy-tripdata]
    UNION ALL
    SELECT * FROM [Cyclistic]..[202508-divvy-tripdata]
)
SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    DATEDIFF(MINUTE, started_at, ended_at) AS ride_length_minutes,
    DATENAME(WEEKDAY, started_at) AS day_of_week,
    member_casual
FROM all_trips
WHERE
    started_at < ended_at
    AND DATEDIFF(MINUTE, started_at, ended_at) > 0
    AND DATEDIFF(HOUR, started_at, ended_at) < 24;
