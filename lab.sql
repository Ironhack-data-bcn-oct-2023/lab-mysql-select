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
select count(*) from rental
where rental_date >= (select max(rental_date) from rental) - interval 1 month;

-- 9. Get film ratings.
select distinct rating from film;

-- 10. Get release years.
select distinct release_year from film;

-- 11. Get all films with ARMAGEDDON in the title.
select * from film as f
where f.title like '%ARMAGEDDON%';

-- 12. Get all films with APOLLO in the title
select * from film as f
where f.title like '%APOLLO%';

-- 13. Get all films which title ends with APOLLO.
select * from film as f
where f.title like '%APOLLO';

-- 14. Get all films with word DATE in the title.
select * from film as f
where f.title like '%DATE%';

-- 15. Get 10 films with the longest title.
select title, length(title) from film as f
order by length(f.title) desc limit 10;

-- 16. Get 10 the longest films.
select title, length from film as f
order by length desc limit 10;

-- 17. How many films include Behind the Scenes content?
select count(*) as film_w_b_t_s from film as f
where f.special_features like '%Behind the Scenes%';

-- 18. List films ordered by release year and title in alphabetical order.
select * from film order by title asc;

-- 19. Drop column picture from staff.
alter table staff drop column picture;

-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
insert into staff (store_id, first_name, last_name, address_id, username)
select store_id, first_name, last_name, address_id, 'tammyta_sanders' from customer
where first_name = 'Tammy' and last_name = 'Sanders';

-- 21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current
-- date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information
-- you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id
-- information as well. To get that you can use the following query:
insert into rental (rental_date, customer_id, staff_id, inventory_id)
values (
	curdate(),
    (select customer_id from customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER'),
    (select staff_id from staff where first_name = 'Mike' and last_name = 'Hillyer'),
    (select max(inventory_id) from inventory where film_id = (select max(film_id) from film where title = 'Academy Dinosaur') and store_id = 1)
);

-- 22. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date
-- for the users that would be deleted. Follow these steps:
	-- Check if there are any non-active users
	-- Create a table backup table as suggested
	-- Insert the non active users in the table backup table
	-- Delete the non active users from the table customer
	select first_name, active from customer where active = 0;
    create table if not exists deleted_users (
		id int auto_increment primary key,
        customer_id bigint not null,
        email varchar(100) not null,
        delete_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    insert into deleted_users (customer_id, email) select customer_id, email from customer where active = 0;
    select * from deleted_users;
    delete from customer where active = 0;
