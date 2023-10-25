USE sakila;

-- 1. How many distinct (different) actors' last names are there?

SELECT COUNT(DISTINCT(last_name)) FROM actor;

-- 2. In how many different languages where the films originally produced? (Use the column language_id from the film table)

SELECT COUNT(DISTINCT(language_id)) FROM film;

-- 3. How many movies were released with "PG-13" rating?

SELECT COUNT(rating) from film
WHERE rating = "PG-13";

-- 4. Get 10 the longest movies from 2006.

SELECT * from film
where release_year >= 2006
ORDER BY length DESC limit 10;

-- 5. How many days has been the company operating (check DATEDIFF() function)?

SELECT DATEDIFF(max(return_date), min(rental_date)) from rental;

-- 6. Show rental info with additional columns month and weekday. Get 20.

SELECT
	rental_date,
	month(rental_date) as month,
	DAYOFWEEK(rental_date) as weekday
from rental
limit 20;

-- 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.


set sql_safe_updates =0;
ALTER TABLE rental
ADD day_type VARCHAR(40);


UPDATE rental
SET day_type = CASE
    WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
    ELSE 'workday'
END;

-- 8 How many rentals were in the last month of activity?

SELECT COUNT(*)
FROM rental
WHERE MONTH(rental_date) = (
    SELECT MONTH(MAX(rental_date)) 
    FROM rental
);

-- 9 Get film ratings.

SELECT title, rating from film

-- 10 Get release years.

SELECT title, release_year from film

-- 11 Get all films with ARMAGEDDON in the title.

SELECT title from film
where title LIKE "%ARMAGEDDON%"

-- 12 Get all films with APOLLO in the title

SELECT title from film
where title LIKE "%APOLLO%"


-- 13 Get all films which title ends with APOLLO.

SELECT title from film
where title LIKE "%APOLLO"

-- 14 Get all films with word DATE in the title.

SELECT title from film
WHERE title REGEXP '\\bDATE\\b';

-- 15 Get 10 films with the longest title.

SELECT title
FROM film
ORDER BY LENGTH(title) DESC
LIMIT 10;

-- 16 Get 10 the longest films.

SELECT title, length
FROM film
ORDER BY LENGTH(length) DESC
LIMIT 10;

-- 17 How many films include Behind the Scenes content?

SELECT COUNT(*)
FROM film
WHERE special_features LIKE "%Behind the Scenes%";


-- 18 List films ordered by release year and title in alphabetical order.

SELECT release_year, title FROM film
ORDER BY release_year 

-- 19 Drop column picture from staff.

ALTER TABLE staff
DROP column picture;

-- 20 A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer.
-- Update the database accordingly.

INSERT INTO staff VALUES("3", "TAMMY", "SANDERS", 4, "tammy.sandres@sakilastaff.com", "2", "1", "Tammy", "tammy", "2023-10-25");


-- 21 Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.
-- You can use current date for the rental_date column in the rental table.
-- Hint: Check the columns in the table rental and see what information you would need to add there.
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well.
-- To get that you can use the following query:

-- select customer_id from sakila.customer
-- where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- Use similar method to get inventory_id, film_id, and staff_id.

SELECT customer_id
FROM customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER';

SELECT film_id
FROM film
WHERE title = 'Academy Dinosaur';

SELECT staff_id
FROM staff
WHERE first_name = 'Mike' AND last_name = 'Hillyer';

SELECT i.inventory_id
FROM inventory AS i
JOIN film AS f ON i.film_id = f.film_id
JOIN store AS s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1;

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (CURRENT_DATE, inventory_id, customer_id, NULL, staff_id);



-- 22 Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:

-- Check if there are any non-active users
SELECT count(active) FROM customer WHERE active = 0 -- yes there are! 15 
​
-- Create a table backup table as suggested
CREATE TABLE back_up_table AS SELECT * FROM customer where active = 0;
SELECT * FROM back_up_table;

-- Insert the non active users in the table backup table
-- I'm actually just str8 up copying if it's non-active which is faster (?)

-- Delete the non active users from the table customer
SET FOREIGN_KEY_CHECKS=0; -- because: #1451 - Cannot delete or update a parent row: a foreign key constraint fails 
-- (...) , CONSTRAINT ... FOREIGN KEY 
-- (...) REFERENCES ... (..))

DELETE FROM customer
WHERE active = 0;

SET FOREIGN_KEY_CHECKS=1;

select * from customer;