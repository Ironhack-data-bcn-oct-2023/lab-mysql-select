use sakila;
#1
select count(distinct last_name) from actor;
#2
select count(distinct language_id) from film;
#3
select count(distinct film_id) from film where rating = "PG-13";
select * from film where rating = "PG-13";
#4
select title from film 
where release_year = "2006" 
order by length desc
limit 10;
#5
select datediff(max(rental_date), min(rental_date)) from rental;
#6
select rental_id, rental_date, staff_id, month(rental_date) as moth, weekday(rental_date) as weekday from rental 
order by rental_date desc
limit 20;

#7
ALTER TABLE rental
ADD day_type varchar(40);
set sql_safe_updates = 0;
update rental
	set day_type =
    case
		when weekday(rental_date) in (0,1,2,3,4,5) then "Weekday" 
        when weekday(rental_date) in (6,7) then "Weekend"
	end;
select * from rental;
#8
select month(max(rental_date)) as max_month, year(max(rental_date)) as year_max from rental;
select count(rental_id) 
	from rental 
	where (month(rental_date), year(rental_date)) = (
    select month(max(rental_date)), year(max(rental_date))
    from rental);
#9 Get film ratings
select rating, count(rating) as count
	from film
    group by rating;
#10 Get release years
select release_year, count(release_year) as count
	from film
    group by release_year;
#11 Get all films with ARMAGEDDON in the title.
select * from film 
	where title like "%ARMAGEDDON%";
#12 Get all films with APOLLO in the title
select * from film 
	where title like "%APOLLO%";
#13 Get all films which title ends with APOLLO.
select * from film 
	where title like "%APOLLO";
#14 Get all films with word DATE in the title.
select * from film 
	where title like "%DATE%";
#15 Get 10 films with the longest title.
select title from film 
order by length(title) desc
limit 10;
# 16 Get 10 the longest films.
select title, length from film 
order by length desc
limit 10;
# 17 How many films include Behind the Scenes content?
select * from film 
	where special_features like "%Behind the Scenes%";
# 18 List films ordered by release year and title in alphabetical order.
select * from film
order by title asc, release_year asc;
# 19 Drop column picture from staff.
alter table staff
drop picture;
#20 A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from customer
	where first_name = "Tammy" and last_name = "Sanders";
insert into staff(staff_id,first_name,last_name,address_id,email,store_id,active,username, last_update)
	select customer_id,first_name,last_name,address_id,email,store_id,active,"-",last_update
	from customer
    where first_name = "Tammy" and last_name = "Sanders";
# 21 - didn't do
insert into rental(rental_date, inventory_id, customer_id, staff_id, last_uptade)
values ("2023-10-25 04:44:31", inventotry_id, 130, 

select * from rental;

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

#22
create table deleted_users as select customer_id, email from customer;

select customer_id, email from customer
	where active = 0;
insert into deleted_users(customer_id, email)
	select customer_id,email
	from customer
    where active = 0;
SET FOREIGN_KEY_CHECKS = 0;
delete from customer
	where active = 0;