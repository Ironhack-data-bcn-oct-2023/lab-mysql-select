USE sakila;

-- 1. How many distinct (different) actors' last names are there?
SELECT first_name, COUNT(*) AS counter 
FROM actor
GROUP BY first_name
HAVING counter = 1;

-- 2. In how many different languages where the films originally produced? (Use the column language_id from the film table)
SELECT language_id, COUNT(*) AS counter
FROM film
GROUP BY language_id;

-- 3. How many movies were released with "PG-13" rating?
SELECT COUNT(*)
FROM film
WHERE rating = "PG-13";

-- 4. Get 10 the longest movies from 2006.
SELECT title, length, release_year
FROM film
WHERE release_year = 2006
ORDER BY length DESC
LIMIT 10;

-- 5. How many days has been the company operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(return_date), MIN(rental_date))
FROM rental;

-- 6. Show rental info with additional columns month and weekday. Get 20.
SELECT *, MONTH(rental_date) AS month, (WEEKDAY(rental_date) + 1) AS weekday
FROM rental;

-- 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *, IF(WEEKDAY(rental_date) + 1 < 6, "workday", "weekend") AS day_type
FROM rental;

-- 8. How many rentals were in the last month of activity?
SELECT COUNT(rental_date)
FROM rental
WHERE rental_date LIKE ("2005-08%");

-- 9. Get film ratings.
SELECT title, rating 
FROM film;

-- 10. Get release years.
SELECT title, release_year
FROM film;

-- 11. Get all films with ARMAGEDDON in the title.
SELECT title
FROM film
WHERE title like "%ARMAGEDDON%";

-- 12. Get all films with APOLLO in the title.
SELECT title
FROM film
WHERE title like "%APOLLO%";

-- 13. Get all films which title ends with APOLLO.
SELECT title
FROM film
WHERE title like "%\APOLLO";

-- 14. Get all films with word DATE in the title.
SELECT title
FROM film
WHERE title like "%DATE%";

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

-- 17. How many films include Behind the Scenes content?
SELECT COUNT(special_features) AS count
FROM film
WHERE special_features like "%Behind the Scenes%";

-- 18. List films ordered by release year and title in alphabetical order.
SELECT title, release_year
FROM film
ORDER BY release_year, title;

-- 19. Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;

-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO staff(first_name, last_name, address_id, email, store_id, active, last_update, username)
-- ??? SELECT first_name, last_name, address_id, email, store_id, active, last_update FROM customer ???
	VALUES ("Tammy", "Sanders", 79, "TAMMY.SANDERS@sakilacustomer.org", 2, 1, "2006-02-15 04:57:20", "tammys");