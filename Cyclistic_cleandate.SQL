USE [Cyclistic BikeShare]
GO

--Merging 12 data table into 1 table
--SELECT *
--FROM tripdata01

INSERT INTO tripdata01
SELECT *
FROM tripdata12;

--Check if all the 12 table is already inserted to Tripdata01
SELECT COUNT(*)
FROM tripdata01;

--Manipulation of data and time
--Getting the difference between Started_at and Ended_time time
SELECT 
started_at,
ended_at,
DATEDIFF(minute,started_at,ended_at) AS ride_length
FROM tripdata01;

--Data cleaning
-- removing Null values in data
SELECT 
start_station_name,
end_station_name,
started_at,
ended_at,
DATEDIFF(minute,started_at,ended_at) AS ride_length
FROM tripdata01
WHERE start_station_name IS NULL;

--Clean Data with Ride length per Minute Duration
CREATE VIEW bikeride AS
WITH clean_data AS
(
	SELECT ride_id, rideable_type,started_at,ended_at, start_station_name,start_lat,end_lat,start_lng,end_lng,
	start_station_id,end_station_name, end_station_id,member_casual, (start_lat-end_lat) AS total_latitude,
	CAST(started_at as date) as start_date,
	CAST(ended_at as date) as end_date,
	CAST(started_at as time) as start_time,
	CAST(ended_at as time) as end_time,
	DATEDIFF(minute,started_at,ended_at) AS ride_length,
	DATENAME(weekday, started_at) AS day_of_week
	FROM tripdata01
	WHERE start_station_name IS NOT NULL
	OR end_station_name IS NOT NULL
)
SELECT * FROM clean_data WHERE ride_length >= 0



--Rechecking all the data
--Count of Bike ride
SELECT COUNT (*)
FROM bikeride
WHERE start_station_name IS NOT NULL
OR end_station_name IS NOT NULL


--Count of Bike ride that done less that 0 minute ride length duration
SELECT COUNT(*)
FROM bikeride;

SELECT COUNT (*)
FROM bikeride WHERE ride_length <= 0;



--Data Agregation 
SELECT AVG(ride_length) AS mem_ride_len
FROM bikeride
WHERE member_casual = 'member';


SELECT MAX(ride_length)
FROM bikeride;

SELECT MIN(ride_length)
FROM bikeride;

SELECT MAX(day_of_week)
FROM bikeride;


