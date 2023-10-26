-- SQL Select Lab
-- Question 1.
use sakila;
select * from actor;
	select count(distinct(last_name)) from actor;
	-- 121

-- 2. 
select * from film;
	select count(distinct(language_id)) from film;
	-- 1 

-- 3.
select count(rating) from film
    where rating = "PG-13";
	-- 223

-- 4.
select title from film
	where release_year = '2006'
	order by length desc
    limit 10;

	-- 'DARN FORRESTER'
	-- 'POND SEATTLE'
	-- 'CHICAGO NORTH'
	-- 'MUSCLE BRIGHT'
	-- 'WORST BANGER'
	-- 'GANGS PRIDE'
	-- 'SOLDIERS EVOLUTION'
	-- 'HOME PITY'
	-- 'SWEET BROTHERHOOD'
	-- 'CONTROL ANTHEM'

-- 5.
select rental_date from rental;
	select datediff(max(rental_date), min(rental_date)) as date_difference
    from rental;
    -- 266 days

-- 6.
select rental_date, dayname(rental_date) as day_of_week, monthname(rental_date) as month from rental
limit 20;

-- 7.
select*,
    case 
		when dayofweek(rental_date) in (1, 7) then "Weekend"
		else "Workday"
		end as day_type
    from rental;

-- 8.
select max(rental_date)
from rental;
-- max rental date is 2006-02-14
select count(rental_date) from rental
	where rental_date between "2006-01-14" and "2006-02-15";
-- 182 rentals in last month of activity

-- 9.
select title, rating from film;

-- 10.
select title, release_year from film;

-- 11.
select title from film
	where title like "%ARMAGEDDON%";
    
-- 12. 
select title from film
	where title like "%APOLLO%";
    
-- 13. 
select title from film
	where title like "%APOLLO";
    
-- 14.
select title from film
	where title like "%DATE%";

-- 15.
select title from film
	order by length(title) desc
    limit 10;

-- 16.
select title, length from film
	order by length desc
    limit 10;
    
-- 17.
select count(*) from film
	where special_features like "%Behind the Scenes%";
	-- 538

-- 18.
select title, release_year from film
	order by release_year and title;

-- 19.
alter table staff
drop column picture;

-- 20.
SELECT * FROM customer
WHERE first_name = "Tammy" AND last_name="Sanders";
INSERT INTO staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update)
VALUES (3, "tammy", "sanders", 79, "TAMMY.SANDERS@sakilacustomer.org", 2, 1,  "Tammy", null, "2006-02-15 04:57:20");

-- 21.

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- customer ID = 130

select staff_id from sakila.staff
where first_name = 'Mike' and last_name = 'Hillyer';

select inventory_id from rental
where customer_id = 130 and staff_id = 1 and store_id = 1;

select film_id from film
where title = "Academy Dinosaur";

select inventory_id from inventory
where film_id = 1 and store_id = 1;

select last_update from film
where film_id = 1 and title = "Academy Dinosaur";

select inventory_id from inventory
where last_update = "2006-02-15 05:03:42" and film_id = 1 and store_id = 1;

insert into rental (rental_date, inventory_id, customer_id, staff_id, last_update)
values ("2023-10-25 18:57:17", 4, 130, 1, now());

select * from rental
where customer_id = 130 and inventory_id = 4;

    insert into rental(day_type)
    values(case 
		when dayofweek(rental_date) in (1, 7) then "Weekend"
		else "Workday"
        end)
    where rental_id = 16050;
    -- esto no funciona
    
    SET SQL_SAFE_UPDATES=0;
UPDATE Rental
SET day_type = CASE 
    WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
    ELSE 'workday'
END;
SET SQL_SAFE_UPDATES=1;

select * from rental
where customer_id = 130 and inventory_id = 4;

-- 22. 

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



    

    
    



    
    
    

        


    
