-- 1 
 select count(last_name) from actor;

-- 2
select count(language_id) from film;

-- 3
select count(rating = "PG-13")  from film;

-- 4 
select title, length, release_year = "2006"
from film
order by length desc
limit 10;

-- 5
select DATEDIFF(max(rental_date), min(rental_date)) from rental;

-- 6
select
    month(rental_date) AS mes,
    WEEKDAY(rental_date) AS dia
from rental
limit 20 ;

-- 7
set SQL_SAFE_UPDATES = 0;
update rental
set day_type = if(WEEKDAY(rental_date) + 1 < 6, "workday", "weekend");



-- 8
select COUNT(*) AS rental_count
from rental
where year(rental_date) = year(NOW()) and month(rental_date) = month(NOW()) -1;

-- 9
select rating
from film;

-- 10
select distinct release_year
from film;

-- 11
select * from film
  where title like "%ARMAGEDDON%";
  
-- 12
select * from film
  where title like "%APOLLO%";
  
-- 13
select * from film
  where title like "%APOLLO";
  
-- 14
select * from film
  where title like "%DATE%";
  
-- 15
select *
from film
order by length(title) desc
limit 10;

-- 16
select *
FROM film
order by length desc
limit 10;

-- 17
select COUNT(special_features)
from film
where special_features like '%Behind the Scenes%';

-- 18
select *
from film
order by release_year, title;

-- 19

-- could not find where the column picture is in the staff table.
-- 20
insert into staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update)
values ('3', 'TAMMY', 'SANDERS', 2, 'TAMMY.SANDERS@sakilacustomer.org', 1, 1, 'tammy', 'password', '2006-02-15 04:57:20');
select * from customer;
select * from staff;
-- 21  
-- ???


-- 22
select COUNT(*) from customer where active = 0;
-- 15 inactive users

create table deleted_users AS
select customer_id, email, create_date
from customer
where active = 0;

delete from customer where active = 0;

select * from deleted_users;