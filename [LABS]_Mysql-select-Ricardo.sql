-- DROP DATABASE IF EXISTS sakila;
use sakila;

-- 1. How many distinct (different) actors' last names are there?
SELECT COUNT(distinct(last_name)) FROM actor; -- 200 last names, 121 unique values

-- 2. In how many different languages where the films originally produced? (Use the column language_id from the film table)
SELECT COUNT(distinct(language_id)) FROM film; -- 1
select * from film;

-- 3. How many movies were released with "PG-13" rating?
Select count(rating) FROM film
	WHERE rating = "PG-13"; -- 223
    
-- 4. Get 10 the longest movies from 2006.
SELECT title, length FROM film ORDER BY length DESC LIMIT 10 -- Gangs Pride, Home Pity, ...

-- 5. How many days has been the company operating (check DATEDIFF() function)?
SELECT datediff(curdate(),min(rental_date)) from rental; -- 6728

-- 6. Show rental info with additional columns month and weekday. Get 20.
SELECT *,
	MONTH(return_date) as month_return_date, weekday(return_date) as weekday_return_date from rental LIMIT 20

-- 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SET SQL_SAFE_UPDATES = 0; -- needed to do this to be able to modify the table
-- ALTER TABLE rental
-- DROP day_type; (needed to do this on and off because I kept messing the column)
ALTER TABLE rental ADD day_type CHAR(7);
	UPDATE  rental
	SET     day_type = IF(weekday(rental_date) = 5 or weekday(rental_date) = 6, "weekend", "workday")

-- 8. How many rentals were in the last month of activity?
SELECT max(rental_date) from rental; -- Last month of activity was February 2006
SELECT count(rental_date) FROM rental
	WHERE rental_date BETWEEN '2006-02-01' AND '2006-03-01';
-- 182

-- 9. Get film ratings. (Are we meant to get the uniques?)
SELECT distinct(rating) FROM film;

-- 10. Get release years.
SELECT distinct(release_year) FROM film;

-- 11. Get all films with ARMAGEDDON in the title.
SELECT * FROM film
	WHERE title LIKE "%ARMAGEDDON%"

-- 12. Get all films with APOLLO in the title
SELECT * FROM film
	WHERE title LIKE "%APOLLO%"
    
-- 13. Get all films which title ends with APOLLO.
SELECT * FROM film
	WHERE title LIKE "%APOLLO"
    
-- 14. Get all films with word DATE in the title.
SELECT * FROM film
	WHERE title LIKE "%DATE%"
    
-- 15. Get 10 films with the longest title.
SELECT title, CHAR_LENGTH(title) FROM film ORDER BY CHAR_LENGTH(title) DESC LIMIT 10

-- 16. Get 10 the longest films.
SELECT title, length FROM film ORDER BY length DESC LIMIT 10

-- 17. How many films include Behind the Scenes content?
SELECT COUNT(special_features) FROM film
	WHERE special_features LIKE "%Behind the Scenes%"  -- 538
    
-- 18. List films ordered by release year and title in alphabetical order.
SELECT title,release_year FROM film ORDER BY release_year,title ASC

-- 19. Drop column picture from staff.
ALTER TABLE staff
	DROP picture;  -- OK!! 
    
-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM customer WHERE first_name = "TAMMY"

INSERT INTO staff (first_name, last_name, address_id, email, store_id, active, username, password, last_update)
VALUES ("TAMMY", "SANDERS", 79, 'TAMMY.SANDERS@sakilacustomer.org' , 2, 1, "Tammy", "1234", now()); -- should email change to corporate or keep the personal one for now?

-- 21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
-- You can use current date for the rental_date column in the rental table. Hint: 
-- Check the columns in the table rental and see what information you would need to add there. 
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
-- To get that you can use the following query:

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

-- Information required: rental_id, rental_date (=now()), inventory_id (Inventory), customer_id (Customer), return_date (Blank), staff_id (Staff), last_update (=now())
-- From Customer I can get: customer_id
-- From staff I can get: staff_id
-- From inventory I can get: inventory_id (based on the film_id that I get from film)


-- rental_id - I will first get the film ID so then I can get the inventory ID from Inventory until finally getting the rental_ID from Rental
SELECT film_id
INTO @film_id_q21
FROM film
WHERE title = 'Academy Dinosaur';

SELECT max(inventory_id)
INTO @inventory_id_q21 -- with this we get inventory_id
FROM inventory
WHERE film_id = @film_id_q21;

SELECT rental_id
INTO @rental_id_q21 -- finally we have it!
FROM rental
WHERE inventory_id = @inventory_id_q21;

-- forget everything, the rental_id is sequential, LOL

select * from rental;

-- now let's get the customer_id for our dear Charlotte. 
-- Funny trivia: Charlotte was born with 6 fingers in her right hand and due to that pursued a 
-- career in anthropology studying our evolution but got fascinated with the evolution of the Neanderthal and before that even dinosaurs.
-- This led her to investigate a bit more about dinos starting to rent movies like Academy Dinosaur. 

SELECT customer_id
INTO @customer_id_q21 -- finally we have it!
FROM customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

-- now let's get the Staff ID:
SELECT staff_id
INTO @staff_id_q21 -- finally we have it!
FROM staff
where first_name = 'Mike' and last_name = 'Hillyer'; -- well, just one last_name Hillyer anyway (also just one first_name Mike)

-- let's finally insert the rental information
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id, return_date)
VALUES (NOW(), @inventory_id_q21+1, @customer_id_q21, @staff_id_q21, NULL); -- adding 1 to inventory ID because it's sequential so it should take the next value after the previous max

select * from rental;

-- 22. Delete non-active users, but first, create a backup table deleted_users 
-- to store customer_id, email, and the date for the users that would be deleted. Follow these steps:

-- Check if there are any non-active users
SELECT count(active) FROM customer WHERE active = 0 -- yes there are! 15 

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

SET FOREIGN_KEY_CHECKS=1; -- to re-enable them

select * from customer;











