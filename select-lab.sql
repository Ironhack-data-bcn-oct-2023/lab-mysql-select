use sakila;

-- 1. How many distinct (different) actors' last names are there?
SELECT 
    COUNT(DISTINCT (last_name))
FROM
    actor;


-- 2. In how many different languages where the films originally produced? (Use the column `language_id` from the `film` table)

SELECT 
    COUNT(DISTINCT (language_id)) as languages 
FROM
    film;
    
    
-- 3. How many movies were released with `"PG-13"` rating?


SELECT 
    COUNT(rating)
FROM
    film
WHERE
    rating = 'pg-13';


-- 4. Get 10 the longest movies from 2006.

SELECT 
    title, length
FROM
    film
where release_year = "2006"
ORDER BY length DESC
LIMIT 10;


-- 5. How many days has been the company operating (check `DATEDIFF()` function)?
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days
FROM
    rental;


-- 6. Show rental info with additional columns month and weekday. Get 20.

SELECT 
    *,
    MONTH(rental_Date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM
    rental
LIMIT 20;



-- 7. Add an additional column `day_type` with values 'weekend' and 'workday' depending on the rental day of the week.

SELECT 
    *,
    MONTH(rental_Date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (2, 3, 4, 5, 6) THEN 'laboral'
        WHEN DAYOFWEEK(rental_date) IN (1 , 7) THEN 'weekend'
    END AS day_type
FROM
    rental;


-- 8. How many rentals were in the last month of activity?

SELECT COUNT(*) AS rental_count
FROM rental
WHERE
    rental_date >= (select max(rental_date) from rental) - interval 1 month;


-- 9. Get film ratings.

SELECT DISTINCT
    (rating)
FROM
    film;


-- 10. Get release years.

select distinct (release_year) from film;



-- 11. Get all films with ARMAGEDDON in the title.

SELECT 
    *
FROM
    film
WHERE
    title like '%armageddon%';
    
    
-- 12. Get all films with APOLLO in the title
SELECT 
    *
FROM
    film
WHERE
    title like '%apollo%';

-- 13. Get all films which title ends with APOLLO.
SELECT 
    *
FROM
    film
WHERE
    title like '%apollo';

-- 14. Get all films with word DATE in the title.
SELECT 
    *
FROM
    film
WHERE
    title like '%date%';
    
    

-- 15. Get 10 films with the longest title.

SELECT 
    title, LENGTH(title)
FROM
    film
ORDER BY length(title) DESC
LIMIT 10;

-- 16. Get 10 the longest films.

select title, length from film
order by length desc
limit 10;

-- 17. How many films include **Behind the Scenes** content?

SELECT 
    COUNT(*)
FROM
    film
WHERE
    special_features LIKE '%behind the Scenes%';

-- 18. List films ordered by release year and title in alphabetical order.

SELECT *
FROM film
ORDER BY title ASC;


-- 19. Drop column `picture` from `staff`.

alter table staff drop column picture;


-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

INSERT INTO staff (store_id, first_name, last_name, address_id, username)
SELECT store_id, first_name, last_name, address_id, 'timmyta_69' 
from customer
WHERE first_name = 'Tammy' and last_name = "sanders";


-- 21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
-- You can use current date for the `rental_date` column in the `rental` table.
-- **Hint**: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. 
-- For eg., you would notice that you need `customer_id` information as well. 
-- To get that you can use the following query:

SELECT customer_id
FROM customer
WHERE first_name = 'Charlotte' AND last_name = 'Hunter';

SELECT i.inventory_id
FROM inventory i
JOIN film f ON i.film_id = f.film_id
JOIN store s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1;

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id, return_date)
VALUES (curdate(), '1', '130', '1');

-- 22. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

    -- Check if there are any non-active users
    -- Create a table _backup table_ as suggested
    -- Insert the non active users in the table _backup table_
    -- Delete the non active users from the table _customer_

drop table if exists backup_table;
CREATE TABLE IF NOT EXISTS backup_table (
    id int primary key auto_increment,
    customer_id INT,
    email VARCHAR(80),
    date DATE
);

INSERT INTO backup_table (customer_id, email, date)
SELECT customer_id, email, last_update
FROM customer
WHERE active = '0';



DELETE FROM payment
WHERE customer_id IN (SELECT customer_id FROM customer WHERE active = '0');

DELETE FROM rental
WHERE customer_id IN (SELECT customer_id FROM customer WHERE active = '0');

DELETE FROM customer
WHERE active = '0';