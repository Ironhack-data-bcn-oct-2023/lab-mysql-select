USE sakila;
SET SQL_SAFE_UPDATES = 0;

-- 1.  How many distinct (different) actors' last names are there? 
SELECT COUNT(DISTINCT last_name)
	FROM actor; 
    -- Answer: 121
    
-- 2. In how many different languages where the films originally produced? (Use the column `language_id` from the `film` table)
SELECT COUNT(DISTINCT language_id)
	FROM film;
    -- Answer: 1
    
-- 3. How many movies were released with `"PG-13"` rating?
SELECT COUNT(rating) FROM film
	WHERE rating = "PG-13";
    -- Answer: 223
    
-- 4. Get 10 the longest movies from 2006.
SELECT title, length
	FROM film
    WHERE release_year = 2006
    ORDER BY length
    LIMIT 10;
	-- Answer: Ridgemont Submarine, Iron Moon, Alien Center, Labyrinth League, Kwai Homeward, Downhill Enough, Halloweeen Nuts, Hanover Galaxy, Divoerce Shining, Hawk Chill
    
-- 5. How many days has been the company operating (check `DATEDIFF()` function)?
SELECT 
    MIN(payment_date) AS first_date,
    MAX(payment_date) AS last_date,
    DATEDIFF(MAX(payment_date), MIN(payment_date)) AS days_difference
FROM payment;
	-- 266 days (it could also be done with rental_date)
    
-- 6. Show rental info with additional columns month and weekday. Get 20.
SELECT
	WEEKDAY(rental_date) AS days,
    MONTH (rentaL_date) AS month
    
FROM rental
LIMIT 20;

-- 7. Add an additional column `day_type` with values 'weekend' and 'workday' depending on the rental day of the week.
ALTER TABLE rental
ADD COLUMN day_type VARCHAR(10);

UPDATE rental
SET day_type = 'workday'
WHERE WEEKDAY(rental_date) BETWEEN 0 AND 4;

UPDATE rental
SET day_type = 'weekend'
WHERE WEEKDAY(rental_date) BETWEEN 5 AND 6;

-- 8. How many rentals were in the last month of activity?
SELECT COUNT(*)
	FROM rental
    WHERE MONTH(rental_date) = (SELECT MONTH(MAX(rental_date)) FROM rental);
    -- 182 rentals in last month
    
-- 9. Get film ratings.
SELECT rating from film; -- all of them

SELECT DISTINCT rating -- all the years we have
	from film;
    
-- 10. Get release years.
SELECT release_year from film; -- all of them

SELECT DISTINCT release_year -- all the years we have
	from film;
    
-- 11. Get all films with ARMAGEDDON in the title.
SELECT title FROM film
WHERE title
LIKE ("%ARMAGEDDON%");

-- 12. Get all films with APOLLO in the title.
SELECT title FROM film
WHERE title
LIKE ("%APOLLO%");

-- 13. Get all films which title ends with APOLLO.
SELECT title FROM film
WHERE title
LIKE ("%APOLLO");

-- 14. Get all films with word DATE in the title.
SELECT title FROM film
WHERE title
REGEXP '\\bDATE\\b';

-- 15. Get 10 films with the longest title.
SELECT title
	FROM film
    ORDER BY length(title) DESC
    LIMIT 10;
    
-- 16. Get 10 the longest films.
SELECT title, length
	FROM film
    ORDER BY length DESC
    LIMIT 10;
    
-- 17. How many films include **Behind the Scenes** content?
SELECT title, special_features 
	FROM film
	WHERE special_features
    LIKE ("%behind the scenes%");
    
    select * from rental
    
-- 18. List films ordered by release year and title in alphabetical order.
-- films ordered:
SELECT title from film
	WHERE title BETWEEN "A" AND "Z";
-- release year ordered:
SELECT release_year FROM film
	ORDER BY release_year;
-- all ordered:
SELECT * FROM film
	ORDER BY title, release_year;

-- 19. Drop column `picture` from `staff`.
ALTER TABLE staff
DROP COLUMN picture;

-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO staff (first_name, last_name, address_id, email, store_id, active, username, password, last_update)
VALUES ('Tammy', 'Sanders', 79, "tammy.sanders@sakilastaff.com", 2, 1, "Tammy", "tammy5849", "2023-10-25 03:57:16");
    
-- 21.  Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
    -- **Hint**: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need `customer_id` information as well. To get that you can use the following query:

INSERT INTO inventory (film_id, store_id)
VALUES (1, 1);

SELECT * FROM inventory
	ORDER BY inventory_id DESC;

INSERT INTO rental (rental_date, inventory_id, customer_id,  staff_id,  day_type)
	VALUES ("2023-10-20 18:02:00", 4582, 130, 1, "workday");

-- 22. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

-- - Check if there are any non-active users
SELECT COUNT(active) FROM customer
	WHERE ACTIVE = 0; -- there are 15 non active users
SELECT * FROM customer
	WHERE active=0;
    
--  Create a table _backup table_ as suggested
CREATE TABLE IF NOT EXISTS deleted_users (
	customer_id SMALLINT PRIMARY KEY,
    email VARCHAR(40),
    date datetime);
    
-- - Insert the non active users in the table _backup table_ WE DON'T INSERT DATA MANUALLY!
INSERT INTO deleted_users(customer_id, email)
SELECT customer_id, email FROM customer
WHERE customer.active=0;

SELECT * from deleted_users;

SELECT active FROM customer;

SET FOREIGN_KEY_CHECKS=0;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM customer WHERE customer.active=0;
SET SQL_SAFE_UPDATES = 1;
SET FOREIGN_KEY_CHECKS=1;

SELECT active FROM customer;
