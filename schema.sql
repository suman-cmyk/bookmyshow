
-- Create the 'city' table
CREATE TABLE IF NOT EXISTS city (
  id serial PRIMARY KEY,
  name TEXT,
  latitude NUMERIC(10, 6),
  longitude NUMERIC(10, 6)
);

-- Create the 'theater' table
CREATE TABLE IF NOT EXISTS theater (
  id serial PRIMARY KEY,
  name VARCHAR,
  totalCount INTEGER
);

-- Create the 'city_theater_map' table
CREATE TABLE IF NOT EXISTS city_theater_map (
  id serial PRIMARY KEY,
  city_id INTEGER REFERENCES city(id),
  theater_id INTEGER REFERENCES theater(id),
  created_at TIMESTAMP,
  isActive BOOLEAN
);

-- Create the 'movie' table
CREATE TABLE IF NOT EXISTS movie (
  id serial PRIMARY KEY,
  name TEXT,
  genre TEXT,
  release_date DATE,
  casts JSONB,
  running_duration INTERVAL
);

-- Create the 'language' table
CREATE TABLE IF NOT EXISTS language (
  id serial PRIMARY KEY,
  name TEXT
);

-- Create the 'movie_language_map' table
CREATE TABLE IF NOT EXISTS movie_language_map (
  id serial PRIMARY KEY,
  movie_id INTEGER REFERENCES movie(id),
  language_id INTEGER REFERENCES language(id)
);

-- Create the 'city_running_movie_map' table
CREATE TABLE IF NOT EXISTS city_running_movie_map (
  id serial PRIMARY KEY,
  movie_id INTEGER REFERENCES movie(id),
  city_id INTEGER REFERENCES city(id)
);

-- Create the 'hall' table
CREATE TABLE IF NOT EXISTS hall (
  id serial PRIMARY KEY,
  theater_id INTEGER REFERENCES theater(id),
  name TEXT,
  address TEXT,
  latitude NUMERIC(10, 6),
  longitude NUMERIC(10, 6),
  "Screen" INTEGER
);

-- Create the 'available_show' table
CREATE TABLE IF NOT EXISTS available_show (
  show_id serial PRIMARY KEY,
  date DATE,
  start_time TIMESTAMP,
  movie_id INTEGER REFERENCES movie(id),
  hall_id INTEGER REFERENCES hall(id)
);

-- Create the 'screen' table
CREATE TABLE IF NOT EXISTS screen (
  id serial PRIMARY KEY,
  name INTEGER,
  totalSeatsCount INTEGER,
  filledSeatsCount INTEGER
);

-- Create the 'seat' table
CREATE TABLE IF NOT EXISTS seat (
  id serial PRIMARY KEY,
  screen_id INTEGER REFERENCES screen(id),
  row CHARACTER,
  number INTEGER,
  type TEXT,
  status TEXT
);

-- Create the 'user' table
CREATE TABLE IF NOT EXISTS "user" (
  id serial PRIMARY KEY,
  name TEXT,
  type TEXT
);

-- Create the 'booking' table
CREATE TABLE IF NOT EXISTS booking (
  id serial PRIMARY KEY,
  user_id INTEGER REFERENCES "user"(id),
  show_id INTEGER REFERENCES available_show(show_id),
  status INTEGER
);

-- Create the 'screen_movie_mapping_inside_a_hall' table
CREATE TABLE IF NOT EXISTS screen_movie_mapping_inside_a_hall (
  id serial PRIMARY KEY,
  screen_id INTEGER REFERENCES screen(id),
  movie_id INTEGER REFERENCES movie(id),
  hall_id INTEGER REFERENCES hall(id)
);

