use sakila;

-- 1. How many distinct (different) actors' last names are there?
select count(distinct last_name) as dist_last_names from actor; -- 121

-- 2. In how many different languages where the films originally produced? (Use the column language_id from the film table)
select count(distinct language_id) from film; -- 1

-- 3. How many movies were released with "PG-13" rating?
select count(rating) from film
	where rating = 'PG-13'; -- 223

-- 4. Get 10 the longest movies from 2006.
select title, length from film
	where release_year = '2006'
    order by length DESC limit 10;

-- 5. How many days has been the company operating (check DATEDIFF() function)?
select datediff(max(rental_date), min(rental_date)) as date_difference from rental; -- 266

-- 6. Show rental info with additional columns month and weekday. Get 20.
select *, month(rental_date) as rental_month, dayname(rental_date) as weekday from rental limit 20;

-- 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
select *, month(rental_date) as rental_month, dayname(rental_date) as weekday,
	case
		when dayofweek(rental_date) in (2, 3, 4, 5, 6) then 'laboral'
        when dayofweek(rental_date) in (1, 7) then 'weekend'
        else 'unknown'
	end as day_type
from rental;

-- 8. How many rentals were in the last month of activity?

-- 9. Get film ratings.

-- 10. Get release years.

-- 11. Get all films with ARMAGEDDON in the title.

-- 12. Get all films with APOLLO in the title

-- 13. Get all films which title ends with APOLLO.

-- 14. Get all films with word DATE in the title.

-- 15. Get 10 films with the longest title.

-- 16. Get 10 the longest films.

-- 17. How many films include Behind the Scenes content?

-- 18. List films ordered by release year and title in alphabetical order.

-- 19. Drop column picture from staff.

-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.