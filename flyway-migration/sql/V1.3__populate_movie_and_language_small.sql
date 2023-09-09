-- Set the 'book_my_show_schema' as the current schema
SET search_path TO bms_schema;

-- Insert movies
INSERT INTO movie (name, genre, release_date, running_duration)
VALUES
  ('Dilwale Dulhania Le Jayenge', 'Romance', '1995-10-20', '3 hours 9 minutes'),
  ('Sholay', 'Action', '1975-08-15', '3 hours 14 minutes'),
  ('3 Idiots', 'Comedy', '2009-12-25', '2 hours 51 minutes'),
  ('Lagaan', 'Drama', '2001-06-15', '3 hours 44 minutes'),
  ('Kuch Kuch Hota Hai', 'Romance', '1998-10-16', '3 hours 5 minutes'),
  ('Baahubali: The Beginning', 'Action', '2015-07-10', '2 hours 39 minutes'),
  ('Dangal', 'Biography', '2016-12-21', '2 hours 41 minutes'),
  ('Golmaal', 'Comedy', '2006-07-14', '2 hours 30 minutes'),
  ('Kabhi Khushi Kabhie Gham', 'Drama', '2001-12-14', '3 hours 31 minutes'),
  ('PK', 'Comedy', '2014-12-19', '2 hours 33 minutes');

-- Insert languages
INSERT INTO language (id, name)
VALUES
  (1, 'English'),
  (2, 'Hindi'),
  (3, 'Spanish'),
  (4, 'French'),
  (5, 'German'),
  (6, 'Mandarin'),
  (7, 'Japanese'),
  (8, 'Korean'),
  (9, 'Russian'),
  (10, 'Arabic');

-- Insert movie-language mappings
INSERT INTO movie_language_map (movie_id, language_id)
VALUES
  (1, 1),  -- Movie 1 in English
  (1, 2),  -- Movie 1 in Hindi
  (2, 3),  -- Movie 2 in Spanish
  (3, 7),  -- Movie 3 in Japanese
  (4, 8),  -- Movie 4 in Korean
  (5, 1),  -- Movie 5 in English
  (6, 1),  -- Movie 6 in English
  (7, 2),  -- Movie 7 in Hindi
  (8, 3),  -- Movie 8 in Spanish
  (9, 4);  -- Movie 9 in French
