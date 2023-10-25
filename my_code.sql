USE sakila;

-- 1 Answers:121
SELECT COUNT(DISTINCT(last_name))
	FROM actor;

-- 2 Answers:1
SELECT COUNT(DISTINCT(language_id))
	FROM film;

-- 3 Answers: 223
SELECT COUNT(rating)
	FROM film
	WHERE rating='PG-13';
    
-- 4 
SELECT title, length
	FROM film
    WHERE release_year=2006
    ORDER BY length DESC
    LIMIT 10;
    
-- 5 Answers: 266
-- RENTAL.rental_date last - first
SELECT MAX(rental_date) as last_rental_date,
	   MIN(rental_date) as first_rental_date,
       DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
	FROM rental;
    
-- 6
SELECT *,
       MONTH(rental_date) AS month,
       WEEKDAY(rental_date) AS week_day
	FROM rental
    LIMIT 20;

-- 7 
ALTER TABLE rental
ADD COLUMN day_type VARCHAR(12);

SET SQL_SAFE_UPDATES = 0;
UPDATE rental
SET day_type = 'weekend' WHERE WEEKDAY(rental_date) in (5,6);
UPDATE rental
SET day_type = 'workday' WHERE WEEKDAY(rental_date) in (0,1,2,3,4);
SET SQL_SAFE_UPDATES = 1;

-- 8 Answers: 182
SELECT COUNT(rental_id)
	FROM rental
    WHERE rental_date LIKE ('2006-02-%');
    
-- 9 
SELECT title,
       rating
	FROM film;

SELECT DISTINCT(rating)
	FROM film;
    
-- 10
SELECT title,
       release_year
	FROM film;
    
SELECT DISTINCT(release_year)
	FROM film;
    
-- 11
SELECT * FROM film
	WHERE title LIKE ('%armageddon%');
    
-- 12
 SELECT * FROM film
	WHERE title LIKE ('%apollo%');   
    
-- 13 
 SELECT * FROM film
	WHERE title LIKE ('%apollo');  
    
-- 14
SELECT * FROM film
	WHERE title LIKE ('%date%');   
    
-- 15
SELECT title
	FROM film
    ORDER BY LENGTH(title) DESC;
    
-- 16
SELECT title, length
	FROM film
    ORDER BY length DESC
    LIMIT 10;
    
-- 17 Answers: 538
SELECT count(special_features) 
	FROM film
    WHERE special_features LIKE ('%Behind the Scenes%');
    
-- 18
SELECT * FROM film
	ORDER BY release_year, title;
    
-- 19
ALTER TABLE staff
DROP COLUMN picture;

-- 20
SELECT * FROM CUSTOMER
	WHERE first_name = 'Tammy';
SELECT * FROM staff
	WHERE first_name = 'Jon';

INSERT INTO staff(first_name, last_name, address_id, email, store_id, active, username)
VALUES ('Tammy','Sanders',79,'tammy.sanders@sakilastaff.com',2,1,'tammy');

SELECT * FROM staff
	WHERE first_name = 'Tammy';


-- 21
SELECT * FROM film
	WHERE title='Academy Dinosaur';
    
SELECT * FROM inventory
	ORDER BY inventory_id DESC;
    
SELECT * FROM customer
	WHERE first_name='Charlotte';
    
SELECT * FROM staff
	WHERE first_name='Mike';
    
INSERT INTO inventory(film_id,store_id)
VALUES(1,1);
    
INSERT INTO rental(rental_date, inventory_id, customer_id, staff_id,day_type)
VALUES('2023-10-25', 4582, 130, 1,'workday');

SELECT * FROM rental
	ORDER BY inventory_id DESC;


-- 22
SELECT * FROM customer
	WHERE active=0;
    
CREATE TABLE IF NOT EXISTS deleted_users (
	customer_id SMALLINT PRIMARY KEY,
    email VARCHAR(400),
    date datetime
);
    
INSERT INTO deleted_users(customer_id,email)
SELECT customer_id, email FROM customer
WHERE customer.active=0;

SELECT * FROM deleted_users;


SET SQL_SAFE_UPDATES = 0;        
DELETE FROM customer WHERE customer.active=0;
SET SQL_SAFE_UPDATES = 1;










