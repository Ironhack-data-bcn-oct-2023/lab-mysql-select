USE sakila;
-- How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name) FROM actor;
-- In how many different languages where the films originally produced? 
-- (Use the column language_id from the film table)
SELECT COUNT(DISTINCT language_id) FROM film;
-- How many movies were released with "PG-13" rating?
SELECT COUNT(*) FROM film WHERE rating = 'PG-13';
-- Get 10 the longest movies from 2006.
SELECT title, length FROM Film WHERE release_year = 2006
ORDER BY length DESC
LIMIT 10;
-- How many days has been the company operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;
-- Show rental info with additional columns month and weekday. Get 20.
SELECT *,
	MONTH(rental_date) AS month,
    DAYOFWEEK(rental_date) AS weekday
FROM
	rental
LIMIT 20;
-- Add an additional column day_type with values 'weekend' and 'workday' depending on 
-- the rental day of the week.
SELECT *,
	MONTH(rental_date) AS month,
    DAYOFWEEK(rental_date) AS weekday,
	CASE
		WHEN DAYOFWEEK(rental_date) in (1,7) THEN "weekend"
        ELSE "workday"
	END AS day_type
FROM rental
LIMIT 20;
-- How many rentals were in the last month of activity?
SELECT 
    YEAR(rental_date) AS year,
    MONTH(rental_date) AS month,
    COUNT(*) AS rental_count
FROM rental
GROUP BY year, month
ORDER BY year DESC, month DESC
LIMIT 1;
-- Get film ratings.
SELECT DISTINCT rating FROM film;
-- Get release years.
SELECT DISTINCT release_year FROM film
ORDER BY release_year;
-- Get all films with ARMAGEDDON in the title.
SELECT * FROM film 
WHERE title LIKE '%ARMAGEDDON%';
-- Get all films which title ends with APOLLO.
SELECT * FROM film
WHERE title LIKE '%APOLLO';
-- Get all films with word DATE in the title.
SELECT * FROM film
WHERE title LIKE '%DATE%';
-- (IF IT WAS JUST THE WORD DATE ALONE THEN:)
SELECT * FROM film
WHERE title REGEXP '\\bDATE\\b';
-- Get 10 films with the longest title.
SELECT title FROM film
ORDER BY CHAR_LENGTH(title) DESC
limit 10;
-- Get 10 the longest films.
SELECT title, length FROM film
ORDER BY length DESC
LIMIT 10;
-- How many films include Behind the Scenes content?
SELECT COUNT(*)FROM film
WHERE special_features LIKE '%Behind the Scenes%';
-- List films ordered by release year and title in alphabetical order.
SELECT title, release_year FROM film
ORDER BY release_year, title;
-- Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;
-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM customer
WHERE first_name = 'Tammy' AND last_name = 'Sanders';

INSERT INTO staff (first_name, last_name, address_id, email, store_id, active, username)
VALUES ('Tammy','Sanders',79,'Tammy.Sanders@sakilacustomer.org',2, 1, 'TAMMY');

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store.
	-- 1. You can use current date for the rental_date column in the rental table. 
	 -- Hint: Check the columns in the table rental and see what information you would need to add there. 
	 -- Use similar method to get inventory_id, film_id, and staff_id. Look at the example in Read.me
SELECT customer_id FROM customer 
WHERE first_name = 'charlotte' AND last_name = 'Hunter'; -- 130
SELECT staff_id FROM staff
WHERE first_name = 'Mike' AND last_name = 'Hillyer'; -- 1
SELECT film_id FROM film
WHERE title = 'Academy Dinosaur'; -- 1
INSERT INTO rental (rental_date, inventory_id, customer_id,staff_id)
VALUES (NOW(), 1, 130, 1);

-- Delete non-active users, but first, create a backup table deleted_users to store 
-- customer_id, email, and the date for the users that would be deleted. Follow these steps:
	-- Check if there are any non-active users
SELECT * FROM customer
WHERE active = 0;
	-- Create a table backup table as suggested
CREATE TABLE deleted_users (
  customer_id INT PRIMARY KEY,
  email VARCHAR(50),
  date DATETIME
);
    -- Insert the non active users in the table backup table
INSERT INTO deleted_users (customer_id, email, date)
SELECT customer_id, email, NOW()
FROM customer WHERE active = 0;
	-- Delete the non active users from the table customer
DELETE FROM customer
WHERE customer_id IN (
  SELECT * FROM (
    SELECT customer_id FROM customer WHERE active = 0
  ) AS subquery
)
LIMIT 1000;  -- Adjust the limit as necessary
