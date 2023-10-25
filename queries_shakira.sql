USE SAKILA;

-- 1. How many distinct (different) actors' last names are there? 21
SELECT COUNT(distinct(last_name)) FROM actor;

-- 2. In how many different languages where the films originally produced? (Use the column `language_id` from the `film` table)
SELECT COUNT(distinct(language_id)) 
	FROM film;
-- Answer: 1 original language

-- 3. How many movies were released with `"PG-13"` rating? 223
SELECT COUNT(rating)
	FROM film
		WHERE rating = "PG-13";

-- 4. Get 10 the longest movies from 2006.
SELECT title, length 
	FROM film
		ORDER by length DESC LIMIT 10; 
-- 5. How many days has been the company operating (check `DATEDIFF()` function)?rental_id
SELECT DATEDIFF(NOW(), MIN(rental_date)) 
	FROM rental;
-- 6. Show rental info with additional columns month and weekday. Get 20.
SELECT *,
       MONTH(return_date) AS return_month,
       DAYOFWEEK(return_date) AS return_weekday
FROM rental
LIMIT 20;

-- 7. Add an additional column `day_type` with values 'weekend' and 'workday' depending on the rental day of the week.
alter table rental add day_type varchar(20);
SET SQL_SAFE_UPDATES=0;
update rental
	set day_type = case
		WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
		ELSE 'workday'
	END; 
SET SQL_SAFE_UPDATES=1;



-- 8. How many rentals were in the last month of activity?
SELECT MAX(rental_date)
	from rental;
    
SELECT COUNT(rental_date) 
from rental
where rental_date between "2006-02-01" and "2006-03-01";

-- 9. Get film ratings.
SELECT distinct(rating)
FROM film;

-- 10. Get release years.
SELECT distinct(release_year)
from film;

-- 11. Get all films with ARMAGEDDON in the title.
select *
from film
where title like "%ARMAGEDDON%";

-- 12. Get all films with APOLLO in the title
SELECT title
from film
where title like "%APOLLO%";

-- 13. Get all films which title ends with APOLLO.
SELECT title
from film
where title like "%APOLLO"; 

-- 14. Get all films with word DATE in the title.
SELECT title
from film
where title like "%DATE%";

-- 15. Get 10 films with the longest title.
SELECT title, char_length(title)
from film
order by char_length(title) DESC 
limit 10;

-- 16. Get 10 the longest films.
select title, length
from film
order by length DESC
limit 10;

-- 17. How many films include **Behind the Scenes** content?
SELECT title
from film
where special_features like "%behind the scenes%";

-- 18. List films ordered by release year and title in alphabetical order.
SELECT title, release_year
from film
order by release_year, title;

-- 19. Drop column `picture` from `staff`.
alter table staff
drop column picture;

-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select *
from customer
where first_name like "tammy";

INSERT INTO staff (first_name, last_name, address_id, email, store_id, active, last_update, username, password)
SELECT first_name, last_name, address_id, email, store_id, active, NOW(), 'tammys', 'password123'
FROM customer
WHERE first_name = 'TAMMY' AND last_name = 'SANDERS';

select *
from staff;

-- 21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
select film_id
from film
where title = "academy dinosaur";

select max(inventory_id)
from inventory
where film_id = "1" and store_id = "1";

select customer_id
from customer
where first_name = "Charlotte" and last_name = "Hunter";

select staff_id
from staff
where first_name = "Mike" and last_name = "Hillyer";

select rental_id
from rental
where inventory_id = "4" and customer_id = "130";

select *
from rental;

SET SQL_SAFE_UPDATES=0;
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id, last_update, day_type)
values (current_date, 4, 130, 1, now(), case WHEN DAYOFWEEK(current_date) IN (1, 7) THEN 'weekend' ELSE 'workday' end);
SET SQL_SAFE_UPDATES=1;

select *
from rental
where inventory_id = "4" and customer_id = "130";

-- 22. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:
select count(active)
from customer
where active = "0";

CREATE TABLE DELETED_USERS (
    customer_id INT,
    email VARCHAR(250),
    deleted_date date
    );
    
    
INSERT INTO deleted_users (customer_id, email, deleted_date)
SELECT customer_id, email, current_date
FROM customer
WHERE active = "0";

select *
from deleted_users;

delete from customer
where active = 0;





    