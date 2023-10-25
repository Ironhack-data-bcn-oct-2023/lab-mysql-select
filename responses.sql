USE sakila;

-- 1
SELECT COUNT(DISTINCT last_name) AS distinct_last_names FROM actor; -- 121 distinct last names

-- 2
SELECT COUNT(DISTINCT language_id) AS distinct_languages FROM film; -- 1 language

-- 3
SELECT COUNT(*) AS pg13_movies FROM film 
	WHERE rating = 'PG-13'; -- 223 movies wit PG-13 rating

-- 4
SELECT title, length FROM film
	WHERE release_year = 2006
	ORDER BY length DESC
	LIMIT 10;

-- 5
SELECT DATEDIFF(NOW(), MIN(rental_date)) AS days_operating FROM rental; -- 6728 operating

-- 6
SELECT *, MONTH(rental_date) AS month, DAYOFWEEK(rental_date) AS weekday FROM rental
LIMIT 20;

-- 7
SELECT *, 
  CASE 
    WHEN DAYOFWEEK(rental_date) IN (7, 8) THEN 'weekend'
    ELSE 'workday'
  END AS day_type
FROM rental;

-- 8
SELECT COUNT(*) AS rentals_last_30_days FROM rental
WHERE rental_date >= DATE_SUB((SELECT MAX(rental_date) FROM rental), INTERVAL 30 DAY); -- 182 rentlas in the last month of activity

-- 9
SELECT DISTINCT rating FROM film;

-- 10
SELECT DISTINCT release_year FROM film;

-- 11
SELECT * FROM film
WHERE title LIKE "%ARMAGEDDON%";

-- 12
SELECT * FROM film
WHERE title LIKE "%APOLLO%";

-- 13
SELECT * FROM film
WHERE title LIKE "%APOLLO";

-- 14
SELECT * FROM film
WHERE title REGEXP '\\bDATE\\b'; -- with regex because otherwise it would take words like CANDIDATE

-- 15
SELECT * FROM film
ORDER BY LENGTH(title) DESC
LIMIT 10;

-- 16
SELECT * FROM film
ORDER BY length DESC
LIMIT 10;

-- 17
SELECT COUNT(*) FROM film
WHERE special_features LIKE "%Behind the Scenes%"; -- 538

-- 18
SELECT * FROM film
ORDER BY release_year, title;

-- 19
ALTER TABLE staff
DROP COLUMN picture;

-- 20
-- SELECT * FROM customer
-- WHERE first_name LIKE 'TAMMY';

INSERT INTO staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password)
SELECT NULL, first_name, last_name, address_id, email, store_id, active, "tammy-username", NULL
FROM customer
WHERE first_name = "TAMMY" AND last_name = "SANDERS";

-- 21
-- get the customer_id for Charlotte Hunter
SELECT customer_id
INTO @customer_id
FROM customer
WHERE first_name = 'Charlotte' AND last_name = 'Hunter';

-- get the film_id for "Academy Dinosaur" so it cab be used to check inventory_id
SELECT film_id
INTO @film_id
FROM film
WHERE title = 'Academy Dinosaur';

-- get the inventory_id using film_id for "Academy Dinosaur"
SELECT inventory_id
INTO @inventory_id
FROM inventory
WHERE film_id = @film_id;

-- get the staff_id for Mike Hillyer
SELECT staff_id
INTO @staff_id
FROM staff
WHERE first_name = 'Mike' AND last_name = 'Hillyer';

-- insert the rental record
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id, return_date)
VALUES (NOW(), @inventory_id, @customer_id, @staff_id, NULL);

-- 22
-- Create the backup table
CREATE TABLE IF NOT EXISTS deleted_users AS
SELECT customer_id, email, NOW() AS deletion_date
FROM customer
WHERE active = 0;

-- Delete the non-active users
DELETE FROM customer
WHERE active = 0;
