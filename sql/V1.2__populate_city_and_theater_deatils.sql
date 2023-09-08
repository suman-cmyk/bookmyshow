
-- Set the 'book_my_show_schema' as the current schema
SET search_path TO bms_schema;

INSERT INTO city (name, latitude, longitude)
VALUES
  ('Mumbai', 19.0760, 72.8777),
  ('Delhi', 28.6139, 77.2090),
  ('Bangalore', 12.9716, 77.5946),
  ('Hyderabad', 17.3850, 78.4867),
  ('Chennai', 13.0827, 80.2707),
  ('Kolkata', 22.5726, 88.3639),
  ('Pune', 18.5204, 73.8567),
  ('Ahmedabad', 23.0225, 72.5714),
  ('Jaipur', 26.9124, 75.7873),
  ('Lucknow', 26.8467, 80.9462);


INSERT INTO theater (name, totalCount)
VALUES
  ('PVR Cinemas', 5),
  ('INOX', 8),
  ('Cinepolis', 7),
  ('AMB Cinemas', 6),
  ('SPI Cinemas', 9),
  ('INOX', 4),
  ('Big Cinemas', 6),
  ('PVR Cinemas', 7),
  ('Cineplex', 5),
  ('Mukta A2 Cinemas', 4);

INSERT INTO city_theater_map (city_id, theater_id, created_at, isActive)
SELECT
  city.city_id,
  theater.theater_id,
  '2023-09-08 12:00:00'::timestamp + (n || ' days')::interval,
  CASE WHEN n % 2 = 0 THEN true ELSE false END
FROM
  (SELECT generate_series(1, 10) as city_id) city
CROSS JOIN
  (SELECT generate_series(1, 6) as theater_id) theater
CROSS JOIN
  generate_series(0, 5) n;

