USE sakila;
SET SQL_SAFE_UPDATES = 0;
-- 1 How many distinct (different) actors' last names are there?

select count(distinct(last_name))
	from actor;  -- 121 unique
    
-- 2 In how many different languages where the films originally produced? (Use the column language_id from the film table)
    
select count(distinct(language_id))
	from film;  -- 1 unique
    
-- 3 How many movies were released with "PG-13" rating?
    
select rating
	from film
    where film.rating = "pg-13"; -- 223 movies
    
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
	from rental; -- 266
    
-- 6. Show rental info with additional columns month and weekday. Get 20.

SELECT *, MONTH(rental_date) as Month,  Dayofweek(rental_date) as Day
	from rental;
    
-- 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
   
SELECT *, IF(weekday(rental_date) +1 < 6,"workday","weekend") as day_type
from rental;

-- 8. How many rentals were in the last month of activity?

select * from rental;
select count(rental_date)
from rental
where rental_date like ("2005-08%");

-- 9. Get film ratings.

select rating
from film;

-- 10. Get release years.

select release_year
from film;

-- 11. Get all films with ARMAGEDDON in the title.

select title
from film
where film.title like ("%ARMAGEDDON%");

-- 12. Get all films with APOLLO in the title

select title
from film
where film.title like ("%apollo%");

-- 13. Get all films which title ends with APOLLO.

select title
from film
where film.title like ("%apollo");

-- 14. Get all films with word DATE in the title.

select title
from film
where film.title like ("% date%") or film.title like ("%date %");

-- 15. Get 10 films with the longest title.

Select title
from film
order by LENGTH(title) desc
limit 10;

-- 16. Get 10 the longest films.

select length, title
	from film
    order by length desc
    limit 10; 
    
-- 17. How many films include Behind the Scenes content?

select special_features
from film
where film.special_features = "behind the scenes";

-- 18. List films ordered by release year and title in alphabetical order.

select title 
from film
order by film.title asc, film.release_year;

-- 19. Drop column picture from staff.alter

ALTER TABLE staff
DROP COLUMN picture;

-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

select * from customer
where first_name = "Tammy" and last_name="Sanders";
INSERT INTO staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update)
values (3, "tammy", "sanders", 79, "SANDERS@sakilacustomer.org", 2, 1,  "Tammy", null, "2006-02-15 04:57:2");

-- 21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date 
-- for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you 
-- would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
-- To get that you can use the following query:

insert into rental (rental_date, customer_id, staff_id, inventory_id)
values (
	curdate(),
    (select customer_id from customer where first_name = 'Charlotte' and last_name = 'Hunter'),
    (select staff_id from staff where first_name = 'Mike' and last_name = 'Hillyer'),
    (select max(inventory_id) from inventory where film_id = (select max(film_id) from film where title = 'Academy Dinosaur') and store_id = 1)
    );
    
-- 22. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, 
-- and the date for the users that would be deleted. Follow these steps:
-- Check if there are any non-active users
-- Create a table backup table as suggested
-- Insert the non active users in the table backup table
-- Delete the non active users from the table customer
select * from customer where active = 0;

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE deleted_users as SELECT customer_id, email, current_date() from customer where active = "0";

DELETE FROM customer WHERE active = 0;


    -- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

    -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`sakila`.`payment`, CONSTRAINT `fk_payment_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE)

    
