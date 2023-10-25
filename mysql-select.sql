USE sakila;
-- How many distinct (different) actors' last names are there?
select count(distinct(last_name)) from actor;

-- In how many different languages where the films originally produced? (Use the column `language_id` from the `film` table)
select count(distinct(language_id)) from film;

-- How many movies were released with `"PG-13"` rating?
select count(rating) from film 
where rating = "PG-13";

-- Get 10 the longest movies from 2006.
select * from film
where release_year >= 2006 
order by length desc limit 10;

-- How many days has been the company operating (check `DATEDIFF()` function)?
select datediff(max(return_date), min(rental_date)) as date_diff from rental;

-- Show rental info with additional columns month and weekday. Get 20.
select
rental_date,
month(rental_date) as month, 
DAYOFWEEK(rental_date) as dayofweek
from rental
LIMIT 20; 

-- Add an additional column `day_type` with values 'weekend' and 'workday' depending on the rental day of the week.


set sql_safe_updates = 0;
alter table rental
add day_type varchar(10);

UPDATE rental
SET day_type = CASE
                WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'Weekend'
                ELSE 'Worday'
              END;

-- How many rentals were in the last month of activity?
select count(*)
from rental
where month(rental_date) = (select month(max(rental_date)) from rental);

-- Get film ratings
select title, rating from film

-- Get release years.
select title, release_year 
from film

-- Get all films with ARMAGEDDON in the title.
select title from film
where title like "%ARMAGEDDON%"

-- Get all films with APOLLO in the title
select title from film
where title like "%APOLLO%"

-- Get all films which title ends with APOLLO.
select title from film
where title like "%APOLLO"

-- Get all films with word DATE in the title.
select title from film
where title regexp '\\bDATE\\b'

-- Get 10 films with the longest title.
select title from film
order by length(title) desc
limit 10;

-- Get 10 the longest films.
select title, length from film
order by length(length) desc
limit 10;

-- How many films include **Behind the Scenes** content?
select count(*)
from film
where special_features like "%Behind the Scenes%";

-- List films ordered by release year and title in alphabetical order.
select release_year, title from film
order by release_year

-- Drop column `picture` from `staff`
alter table staff
drop column picture;

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from staff
where first_name = "JON";

INSERT INTO STAFF VALUES("3", "Tammy", "Sanders", 6, "tammy.sanders@sakilastaff.com", "2", "1", "tammy", "tammy", "2023-10-25")



