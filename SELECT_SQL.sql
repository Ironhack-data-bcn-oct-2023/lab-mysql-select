 USE sakila;

-- How many distinct (different) actors' last names are there?

 SELECT COUNT(DISTINCT last_name) AS distinct_last_names
 from actor;
 
 -- In how many different languages where the films originally produced? (Use the column `language_id` from the `film` table)
 
SELECT COUNT(DISTINCT language_id) AS different_languages
FROM film;

-- How many movies were released with `"PG-13"` rating?
SELECT COUNT(*) as PG_13
FROM FILM
WHERE RATING = 'PG-13';

-- Get 10 the longest movies from 2006.

SELECT title, length, release_year
FROM film
WHERE release_year = 2006
ORDER BY length DESC
LIMIT 10;

-- How many days has been the company operating (check `DATEDIFF()` function)?

select DATEDIFF(max(return_date), min(rental_date))
from rental;

-- 6. Show rental info with additional columns month and weekday. Get 20.

SELECT rental_id, rental_date, 
       MONTH(rental_date) AS month,
       dayname(rental_date) AS weekday
FROM rental
LIMIT 20;

-- 7. Add an additional column `day_type` with values 'weekend' and 'workday' depending on the rental day of the week. *******

select *, 
IF(dayofweek(rental_date)<= 5, "work", "weekend") as day_type from rental;

-- 8. How many rentals were in the last month of activity? ****

select year(rental_date) as year_r, month(rental_date) as month_r,count(rental_id) 
from rental 
group by year(rental_date),month(rental_date)
order by year(rental_date) desc,month(rental_date) desc
limit 1;

-- 9. Get film ratings.

select rating,count(rating) as numfilms from film
group by rating
order by numfilms desc;

-- 10. Get release years.

select release_year,count(release_year) as numfilms from film
group by release_year
order by numfilms desc;

-- 11. Get all films with ARMAGEDDON in the title.

select * 
from film
where title like "%armageddon%";

-- 12. Get all films with APOLLO in the title

select *
from film
where title like "%Apollo%";

-- 13. Get all films which title ends with APOLLO.

select *
from film
where title like"%Apollo";

-- 14. Get all films with word DATE in the title.

select *
from film
where title like '%date%';

-- 15. Get 10 films with the longest title.

select title
from film
order by length(title) desc
limit 10;

-- 16. Get 10 the longest films.

select title, length
from film
order by length desc
limit 10;

-- 17. How many films include **Behind the Scenes** content?

SELECT COUNT(*) as behind_scenes
FROM FILM
WHERE special_features like '%Behind the scenes%';

-- 18. List films ordered by release year and title in alphabetical order.

select title, release_year
from film
order by release_year, title;

-- 19. Drop column `picture` from `staff`.

alter table staff
drop column picture;


-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

select * from customer
where first_name = 'Tammy' and last_name='Sanders';

INSERT INTO staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update)
values (3, "tammy", "sanders", 79, "TAMMY.SANDERS@sakilacustomer.org", 2, 1,  "Tammy", null, "2006-02-15 04:57:20");

-- 21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.


insert into rental (rental_date, inventory_id, customer_id, staff_id) values
((current_date()),
(select max(inventory_id) from inventory where film_id = (select max(film_id) from film where title = "Academy Dinosaur") and store_id = 1) ,
(select customer_id from customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER'),
(select staff_id from staff where first_name = 'MIKE' and last_name = 'HILLYER')
);




-- 22. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

--    - Check if there are any non-active users
--    - Create a table _backup table_ as suggested
--   - Insert the non active users in the table _backup table_
--    - Delete the non active users from the table _customer_

select * from customer where active = 0; -- 15 non active customers

	-- Create a table backup table as suggested
	-- Insert the non active users in the table backup table
create table deleted_users as select customer_id, email, current_date() from customer where active = 0;

	-- Delete the non active users from the table customer
delete from customer where active = 0;























