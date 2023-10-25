SET SQL_SAFE_UPDATES = 0;
USE sakila;
-- 1 How many distinct (different) actors’ last names are there?
select count(distinct(last_name))
	from actor;  -- 121 unique
-- 2 In how many different languages where the films originally produced? (Use the column language_id from the film table)
select count(distinct(language_id))
	from film;  -- 1 unique
-- 3 How many movies were released with “PG-13” rating?
select rating
	from film
    where film.rating = "pg-13";

--  4 Get 10 the longest movies from 2006.
select length, title
	from film
    where film.release_year > "2005"
    order by length desc
    limit 10;

-- 5 How many days has been the company operating (check DATEDIFF() function)?
select rental_date
	from rental
    order by rental_date desc; -- 2006-02-14 15:16:03
select rental_date
	from rental
    order by rental_date asc;  --  2005-05-24 22:53:30
select datediff(max(rental_date), min(rental_date)) as days
	from rental;
    
-- 6. Show rental info with additional columns month and weekday. Get 20.
SELECT *, MONTH(rental_date) as Month,  Dayofweek(rental_date) as Day
	from rental;
    
-- 7. Add an additional column day_type with values ‘weekend’ and ‘workday’ depending on the rental day of the week.
SELECT *, IF(weekday(rental_date) +1 < 6,“workday”,“weekend”) as day_type
from rental;

-- 8. How many rentals were in the last month of activity?
SELECT * from rental;
SELECT COUNT(rental_date)
FROM rental 
WHERE rental_date LIKE ("2005-08%");

-- 9. Get film ratings.
SELECT rating
FROM film;

-- 10. Get release years.
SELECT release_year
FROM film;

-- 11. Get all films with ARMAGEDDON in the title.
SELECT title
FROM film 
WHERE film.title LIKE ("%ARMAGEDDON%");

-- 12. Get all films with APOLLO in the title
SELECT title
FROM film 
WHERE film.title LIKE ("%APOLLO%");

-- 13. Get all films which title ends with APOLLO.
SELECT title
FROM film 
WHERE film.title LIKE ("%APOLLO");

-- 14. Get all films with word DATE in the title.
SELECT title
FROM film 
WHERE film.title LIKE ("% DATE%") OR film.title LIKE ("%DATE %");

-- 15. Get 10 films with the longest title.
SELECT title
FROM film
ORDER BY LENGTH(title) DESC
LIMIT 10;

-- 16. Get 10 the longest films.
SELECT length, title
	FROM film
    ORDER BY length DESC
    LIMIT 10;
    
-- 17. How many films include Behind the Scenes content?
SELECT special_features
	FROM film 
	WHERE film.special_features = "Behind the Scenes";
    
-- 18. List films ordered by release year and title in alphabetical order.
SELECT title
FROM film 
ORDER BY film.title ASC, film.release_year;

-- 19. Drop column picture from staff.
ALTER TABLE staff 
DROP COLUMN picture;
SELECT * from staff;

-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM customer
WHERE first_name = "Tammy" AND last_name="Sanders";
INSERT INTO staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update)
VALUES (3, "tammy", "sanders", 79, "TAMMY.SANDERS@sakilacustomer.org", 2, 1,  "Tammy", null, "2006-02-15 04:57:20");

-- 21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
INSERT INTO rental (rental_date, customer_id, staff_id, inventory_id)
VALUES (
	curdate(),
    (SELECT customer_id FROM customer WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER'),
    (SELECT staff_id FROM staff WHERE first_name = 'Mike' AND last_name = 'Hillyer'),
    (SELECT max(inventory_id) FROM inventory WHERE film_id = (SELECT max(film_id) FROM film WHERE title = 'Academy Dinosaur') AND store_id = 1)
);

-- 22. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
-- Check if there are any non-active users
-- Create a table backup table as suggested
-- Insert the non active users in the table backup table
-- Delete the non active users from the table customer
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE deleted_users AS SELECT customer_id, email, current_date() FROM customer WHERE active = 0;
DELETE FROM customer WHERE active = 0;
