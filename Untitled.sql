use sakila;

-- 1 
select COUNT(DISTINCT(last_name)) from actor;

-- 2
SELECT count(distinct(language_id)) from language;

-- 3
select count(rating) from film
	where rating = "PG-13";
    
-- 4
select title from film
	where release_year = 2006
    order by rental_duration
    limit 5;
    
-- 5 
select datediff(MIN(rental_date),MAX(rental_date))
from rental;

-- 6 
select rental_date,
	extract(month from rental_date) as rental_month,
    extract(day from rental_date) as week_day
    from rental;
    
-- 7
SELECT*, 
    MONTH(rental_Date) AS month,
    DAYNAME(rental_date) AS week_day,
		Case
        WHEN DAYOFWEEK(rental_date) IN (2, 3, 4, 5, 6) THEN 'workday'
        WHEN DAYOFWEEK(rental_date) IN (1 , 7) THEN 'weekend'
    END 
    AS day_type
FROM rental;
    
-- 8 
SELECT * from rental;
SELECT COUNT(rental_date)
FROM rental 
WHERE rental_date LIKE ("2005-08%");

-- 9 
SELECT rating
FROM film;

-- 10
SELECT release_year
FROM film;
-- 11
SELECT title
FROM film 
WHERE film.title LIKE ("%ARMAGEDDON%");
-- 12
SELECT title
FROM film 
WHERE film.title LIKE ("%APOLLO%");
-- 13
SELECT title
FROM film 
WHERE film.title LIKE ("%APOLLO");
-- 14
SELECT title
FROM film 
WHERE film.title LIKE ("% DATE%") OR film.title LIKE ("%DATE %");
-- 15
SELECT title
FROM film
ORDER BY LENGTH(title) DESC
LIMIT 10;

-- 16
SELECT length, title
	FROM film
    ORDER BY length DESC
    LIMIT 10;
    
-- 17
SELECT special_features
	FROM film 
	WHERE film.special_features = "Behind the Scenes";
    
-- 18
SELECT title
FROM film 
ORDER BY film.title ASC, film.release_year
;
-- 19
ALTER TABLE staff 
DROP COLUMN picture;
SELECT * from staff;

-- 20
SELECT * FROM customer
WHERE first_name = "Tammy" AND last_name="Sanders";
INSERT INTO staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update)
VALUES (3, "tammy", "sanders", 79, "TAMMY.SANDERS@sakilacustomer.org", 2, 1,  "Tammy", null, "2006-02-15 04:57:20")
;

-- 21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
INSERT INTO rental (rental_date, customer_id, staff_id, inventory_id)
VALUES (
	curdate(),
    (SELECT customer_id FROM customer WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER'),
    (SELECT staff_id FROM staff WHERE first_name = 'Mike' AND last_name = 'Hillyer'),
    (SELECT max(inventory_id) FROM inventory WHERE film_id = (SELECT max(film_id) FROM film WHERE title = 'Academy Dinosaur') AND store_id = 1)
);
-- 22
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE deleted_users AS SELECT customer_id, email, current_date() FROM customer WHERE active = 0;
DELETE FROM customer WHERE active = 0;



