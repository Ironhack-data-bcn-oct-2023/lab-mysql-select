USE sakila;

-- How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT(last_name)) FROM actor; -- 121 different actors' last name

-- In how many different languages where the films originally produced?
SELECT COUNT(DISTINCT(language_id)) FROM film; -- Only 1 language

-- How many movies were released with "PG-13" rating?
SELECT COUNT(rating) FROM film
	WHERE rating = "PG-13"; -- 223 movies rated PG-13

-- Get 10 the longest movies from 2006.
SELECT title FROM film
WHERE release_year = 2006
ORDER BY length DESC
LIMIT 10; -- Darn Forrester, Pond Seattle, Chicago North, Muscle Bright, Worst Banger, Gangs Pride,
		  -- Soldiers evolution, Home pity, Sweet Brotherhood, Control Anthem

-- How many days has been the company operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) FROM rental; -- 266 days

-- Show rental info with additional columns month and weekday. Get 20.
SELECT *, MONTH(rental_date) AS rental_month, WEEKDAY(rental_date) AS rental_day
FROM rental
LIMIT 20;
	-- 0 = Monday, 1 = Tuesday, 2 = Wednesday, 3 = Thursday, 4 = Friday, 5 = Saturday, 6 = Sunday.

-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE rental 
	ADD day_type CHAR (7);
UPDATE rental
SET day_type = "workday"
WHERE WEEKDAY(rental_date) BETWEEN 0 AND 4;
UPDATE rental
SET day_type = "weekend"
WHERE WEEKDAY(rental_date) BETWEEN 5 AND 6;

-- How many rentals were in the last month of activity?
SELECT COUNT(*)
	FROM rental
	WHERE MONTH(rental_date) = (SELECT MONTH(MAX(rental_date)) FROM rental); -- 182 rental in the last month

-- Get film ratings.
SELECT DISTINCT(rating) FROM film;

-- Get release years.
SELECT DISTINCT(release_year) FROM film; -- All were released in 2006

-- Get all films with ARMAGEDDON in the title.
SELECT * FROM film
	WHERE title LIKE "%armageddon%";

-- Get all films with APOLLO in the title
SELECT * FROM film
	WHERE title LIKE "%apollo%";
    
-- Get all films which title ends with APOLLO.
SELECT * FROM film
	WHERE title LIKE "%apollo";
    
-- Get all films with word DATE in the title.
SELECT * FROM film
	WHERE title LIKE "%date%";
    
-- Get 10 films with the longest title.
SELECT * FROM film
ORDER BY CHAR_LENGTH(title) DESC
LIMIT 10;

-- Get 10 the longest films.
SELECT * FROM film
ORDER BY length DESC
LIMIT 10;

-- How many films include Behind the Scenes content?
SELECT COUNT(*) FROM film
	WHERE special_features LIKE "%Behind the Scenes%"; -- 538 films include Behind the scenes

-- List films ordered by release year and title in alphabetical order.
SELECT * FROM film
	ORDER BY release_year, title;

-- Drop column picture from staff.
ALTER TABLE staff
	DROP COLUMN picture;

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer.
SELECT * FROM customer
WHERE first_name = "Tammy" AND last_name = "Sanders";
SELECT * FROM staff
WHERE first_name = "Jon"; -- store_id = 2
INSERT INTO staff (first_name, last_name, address_id, email, store_id, username)
VALUES ("Tammy", "Sanders", 79, "tammy.sanders@sakilacustomer.org", 2, "Tammy");

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. Use current date for the rental_date.
-- Columns in rental: rental_date, inventory_id, customer_id)
SELECT * FROM film
	JOIN inventory
		ON film.film_id = inventory.film_id
	WHERE title = "Academy Dinosaur" AND store_id = 1; -- inventory_id of this film in store 1 has 4 different values (1, 2, 3, 4)
SELECT * FROM customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER'; -- customer_id = 130
SELECT * FROM staff
	WHERE store_id = 1; -- in store_id =1, the staff working there is staff_id = 1
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (curdate(), 1, 130, 1);

-- Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
	-- 1. Check if there are any non-active users
    -- 2. Create a table backup table as suggested
    -- 3. Insert the non active users in the table backup table
    -- 4. Delete the non active users from the table customer
SELECT * FROM customer WHERE active = 0;
SELECT COUNT(*) FROM customer WHERE active = 0; -- There are 15 non-active users
CREATE TABLE IF NOT EXISTS deleted_users(
customer_id SMALLINT PRIMARY KEY,
email VARCHAR(50),
date DATE
);

INSERT INTO deleted_users (customer_id, email)
SELECT customer_id, email FROM customer
WHERE customer.active = 0;
UPDATE deleted_users
SET date = curdate();

SET FOREIGN_KEY_CHECKS=0; 
DELETE FROM customer WHERE active = 0;
SET FOREIGN_KEY_CHECKS=1;