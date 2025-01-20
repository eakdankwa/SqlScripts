/*      Where Clause
Write a query in SQL to find the name and year of the movies.
Write a query in SQL to find the year when the movie American Beauty released.
Write a query in SQL to find the movie which was released in the year 1999.
Write a query in SQL to find the movies which was released before 1998. 
Write a query in SQL to return the name of all reviewers and name of movies together in a single list.
Write a query in SQL to find the name of all reviewers who have rated 7 or more stars to their rating.
Write a query in SQL to find the titles of all movies that have no ratings.
Write a query in SQL to find the titles of the movies with ID 905, 907, 917.
Write a query in SQL to find the list of all those movies with year which include the words Boogie Nights. 
Write a query in SQL to find the ID number for the actor whose first name is 'Woody' and the last name is 'Allen'.
*/

SELECT * FROM movie.movies;
SELECT mov_name, mov_year FROM movie.movies;  -- Q1 
SELECT mov_year FROM movies WHERE mov_name like '%merican Beauty%'; -- Q2
SELECT mov_name FROM movies WHERE mov_year = 1999;
SELECT mov_name  FROM movies WHERE mov_year < 1998;
SELECT rev_name AS reviewers_and_mov_name FROM movies UNION SELECT mov_name FROM movies;
-- SELECT CONCAT(rev_name, mov_name) FROM  movies;
-- SELECT rev_name, mov_name FROM  movies;
SELECT rev_name FROM movies WHERE rev_stars >= 7;
SELECT mov_name FROM movies WHERE num_o_ratings = '';
SELECT mov_name FROM movies WHERE mov_id IN(905, 907, 917);
SELECT mov_name, mov_year FROM movies WHERE mov_name LIKE '%oogie ight%';