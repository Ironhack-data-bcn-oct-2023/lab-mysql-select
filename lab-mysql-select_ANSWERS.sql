USE sakila;
-- 1. How many distinct (different) actors' last names are there?
SELECT * FROM actor;
	SELECT count(DISTINCT(last_name)) FROM actor;
	-- A: 121

-- 2. In how many different languages were the films originally produced? (Use the column language_id from the film table)
SELECT * FROM film;
	SELECT count(DISTINCT(language_id)) FROM film;
	-- A: 1

-- 3. How many movies were released with "PG-13" rating?
SELECT count(rating) FROM film
	WHERE rating LIKE ("PG-13");
	-- A: 223

-- 4. Get 10 the longest movies from 2006.
SELECT length, title FROM film
WHERE release_year = 2006
	ORDER BY length DESC 
    LIMIT 10;
	-- A: CHICAGO NORTH, CONTROL ANTHEM, DARN FORRESTER, GANGS PRIDE, HOME PITY, MUSCLE BRIGHT, POND SEATTLE, SOLDIERS EVOLUTION, SWEET BROTHERHOOD,  WORST BANGER (ALL: 185)

-- 5. How many days has been the company operating (check DATEDIFF() function)?
SELECT rental_date FROM rental;
	SELECT DATEDIFF(max(rental_date), min(rental_date)) as date_difference
    FROM rental;
    -- A: 266 Days
    
-- 6. Show rental info with additional columns month and weekday. Get 20.
SELECT 
    rental_date, 
    DAYNAME(rental_date) AS weekday, 
    MONTHNAME(rental_date) AS Month
FROM rental
LIMIT 20;

-- 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

ALTER TABLE Rental ADD day_type VARCHAR(20);

UPDATE Rental
	SET day_type = CASE 
		WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend'
		ELSE 'workday'
	END;


-- 8. How many rentals were in the last month of activity?
Select count(rental_date) FROM Rental
	WHERE rental_date
		BETWEEN '2006-02-01' and '2006-03-01';
	-- A: 182
-- 9. Get film ratings.
SELECT rating FROM FILM;
	-- A: SELECT rating FROM FILM;
-- 10. Get release years.
SELECT release_year FROM FILM;
	-- A:SELECT release_year FROM FILM;
-- 11. Get all films with ARMAGEDDON in the title.
SELECT * FROM FILM
	WHERE title LIKE "%ARMAGEDDON%";
	-- A:SELECT * FROM FILM WHERE title LIKE "%ARMAGEDDON%";
-- 12. Get all films with APOLLO in the title
SELECT * FROM FILM
	WHERE title LIKE "%APOLLO%";
	-- A:SELECT * FROM FILM WHERE title LIKE "%APOLLO%";
-- 13. Get all films which title ends with APOLLO.
SELECT * FROM FILM
	WHERE title LIKE "%APOLLO";
	-- A: SELECT * FROM FILM WHERE title LIKE "%APOLLO";
-- 14. Get all films with word DATE in the title.
SELECT * FROM FILM
	WHERE title LIKE "%DATE%";
	-- A: SELECT * FROM FILM WHERE title LIKE "%DATE%";
-- 15. Get 10 films with the longest title.
SELECT title from FILM
	order by LENGTH(title) desc LIMIT 10;
    -- A: SELECT title from FILM Order by LENGTH(title) desc LIMIT 10;
-- 16. Get 10 the longest films.
SELECT length, title FROM film
	ORDER BY length desc LIMIT 10;
	-- A: They are all 185 min Long
-- 17. How many films include Behind the Scenes content?
SELECT count(special_features) FROM FILM 
	WHERE special_features like "%Behind the Scenes%";
	-- A: 538 
-- 18. List films ordered by release year and title in alphabetical order.
SELECT release_year, title FROM FILM
	ORDER BY release_year AND title;
	-- A: SELECT release_year, title FROM FILM ORDER BY release_year AND title;
-- 19. Drop column picture from staff.
SELECT picture FROM staff;
ALTER TABLE staff DROP COLUMN picture;
	-- A: ALTER TABLE staff DROP COLUMN picture;
-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECt * FROM customer
	Where first_name = "Tammy" and last_name = "Sanders";
    INSERT INTO staff(staff_id, first_name, last_name, address_id, email, store_id, Username, active, password, last_update)
	VALUES(3, "Tammy", "Sanders", 79, 'TAMMY.SANDERS@sakilacustomer.org', 1, "Tammy", 1, NULL, '2006-02-14 22:04:36');
    -- A:
-- 21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
--     You can use current date for the rental_date column in the rental table.
-- Inventory ID : 130 
-- Add Rental : rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update, day_type
SELECT film_id 
FROM film 
WHERE title = 'Academy Dinosaur';
-- film_id = 1

SELECT inventory_id 
FROM inventory 
WHERE film_id = "1" AND store_id = 1;
-- inventory_id = 1-4

SELECT staff_id 
FROM staff 
WHERE first_name = 'MIKE' AND last_name = 'HILLYER';
-- Staff_id = 1

SELECT customer_id 
FROM customer 
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER';
-- Customer_id = 130

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id, last_update, day_type) 
VALUES (CURRENT_DATE, 1, 130, 1, NOW(), CASE WHEN DAYOFWEEK(CURRENT_DATE) IN (1, 7) THEN 'weekend' ELSE 'workday'END);
    
SELECT * FROM Rental
	WHERE Customer_ID = "130";
    
-- Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, 
-- and the date for the users that would be deleted

SELECT count(active) FROM Customer 
where active = 0;

CREATE TABLE deleted_users (
    customer_id INT,
    email VARCHAR(255),
    deletion_date DATE
);

insert into deleted_users(customer_id, email, deletion_date)
select customer_id, email, current_date FROM Customer WHERE active = 0;

select * FROM Deleted_users;
SET SQL_SAFE_UPDATES=0;
delete FROM customer where active = 0;
SET SQL_SAFE_UPDATES=1;



    
    