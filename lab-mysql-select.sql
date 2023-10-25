USE sakila;
-- INSTRUCTIONS
-- How many distinct (different) actors last names are there?

	select count(distinct last_name) from actor;

-- In how many different languages where the films originally produced?
-- (Use the column language_id from the film table)

	select count(distinct (language_id)) from film;


 -- How many movies were released with "PG-13" rating?
 
 select rating, count(rating) as numfilms
 from film
 where rating = 'PG-13'
 group by rating;
 

-- Get 10 the longest movies from 2006.

select * from film
where film.release_year >= 2006
order by film.length desc
limit 10;

-- How many days has been the company operating (check DATEDIFF() function)?

SELECT DATEDIFF(max(rental_date),min(rental_date)) as period1 FROM rental;

-- Show rental info with additional columns month and weekday. Get 20.

select *, MONTH(rental_date) as month,dayofweek(rental_date) as week_day from rental;


-- Add an additional column day_type with values 'weekend' and 'workday' 
-- depending on the rental day of the week.

select *, IF(dayofweek(rental_date)<= 5, "work", "weekend") as day_type from rental;

-- How many rentals were in the last month of activity?

select year(rental_date) as year_r, month(rental_date) as month_r,count(rental_id) 
from rental 
group by year(rental_date),month(rental_date)
order by year(rental_date) desc,month(rental_date) desc
limit 1;

-- Get film ratings.
select rating,count(rating) as numfilms from film
group by rating
order by numfilms desc;


-- Get release years.
select release_year,count(release_year) as numfilms from film
group by release_year
order by numfilms desc;

-- Get all films with ARMAGEDDON in the title.
select * from film where title like "%ARMAGEDDON%";

-- Get all films with APOLLO in the title
select * from film where title like "%APOLLO%";

-- Get all films which title ends with APOLLO.
select * from film where title like "%APOLLO";

-- Get all films with word DATE in the title.
select * from film where title like "% DATE%" or title like 'DATE%';

-- Get 10 films with the longest title.
select title, LENGTH(title) as l_movie from film order by l_movie desc limit 10;

-- Get 10 the longest films.
select title , length from film order by length desc limit 10;

-- How many films include Behind the Scenes content?
select count(*) as numfilms from film 
where special_features like "%Behind the scenes%";

-- List films ordered by release year and title in alphabetical order.

select * from film order by release_year, title ASC;

-- Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
-- Update the database accordingly.
INSERT INTO staff (first_name, last_name,address_id,email,store_id,active,username)
SELECT  first_name,last_name,address_id,email,2,1,first_name
FROM customer
WHERE customer_id= (select customer.customer_id from customer where first_name ='TAMMY' and last_name = "SANDERS");

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.
-- You can use current date for the rental_date column in the rental table.
-- Hint: Check the columns in the table rental and see what information you would need to add there.
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well.
-- To get that you can use the following query:
-- select customer_id from sakila.customer
-- where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- Use similar method to get inventory_id, film_id, and staff_id.

insert into rental (rental_date, inventory_id, customer_id, staff_id) values
((current_date()),
(select max(inventory_id) from inventory where film_id = (select max(film_id) from film where title = "Academy Dinosaur") and store_id = 1) ,
(select customer_id from customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER'),
(select staff_id from staff where first_name = 'MIKE' and last_name = 'HILLYER')
);

-- Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
	-- Check if there are any non-active users
select * from customer where active = 0; -- There are 15 non active costumers

	-- Create a table backup table as suggested
	-- Insert the non active users in the table backup table
create table deleted_users as select customer_id, email, current_date() from customer where active = 0;

	-- Delete the non active users from the table customer
delete from customer where active = 0;





