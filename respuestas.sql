-- 1. How many distinct (different) actors' last names are there?
SELECT COUNT(last_name) FROM actor;
-- 200

-- 2. In how many different languages where the films originally produced? (Use the column `language_id` from the `film` table)
SELECT COUNT(language_id) FROM film;
-- 1000

-- 3. How many movies were released with `"PG-13"` rating?
SELECT COUNT(rating ="PG-13") FROM film;
-- 1000

-- 4. Get 10 the longest movies from 2006.
SELECT title, length, release_year = "2006"
FROM film
ORDER BY length DESC
LIMIT 10

-- 5. How many days has been the company operating (check `DATEDIFF()` function)?

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) FROM rental;
-- 266

-- 6. Show rental info with additional columns month and weekday. Get 20.
SELECT
    MONTH(rental_date) AS mes,
    WEEKDAY(rental_date) AS dia
FROM rental
limit 20 ;

-- 7. Add an additional column `day_type` with values 'weekend' and 'workday' depending on the rental day of the week.
ALTER TABLE rental
ADD COLUMN day_type DATETIME;

UPDATE rental
set DAYNAME(rental_date) AS rental_weekday,
 
	WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
           ELSE 'workday'
       END AS day_type,
    rental_day = DAY(rental_date);

-- 8. How many rentals were in the last month of activity?

SELECT  rental_date
FROM film
ORDER BY length DESC


-- 9. Get film ratings.
SELECT DISTINCT rating
FROM film;

-- 10. Get release years.
SELECT DISTINCT release_year
FROM film;

-- 11. Get all films with ARMAGEDDON in the title.
SELECT *
FROM film
WHERE title LIKE '%ARMAGEDDON%';

-- 12. Get all films with APOLLO in the title
SELECT *
FROM film
WHERE title LIKE '%APOLLO%';

-- 13. Get all films which title ends with APOLLO.
SELECT *
FROM film
WHERE title LIKE '%APOLLO';

-- 14. Get all films with word DATE in the title.
SELECT *
FROM film
WHERE title LIKE '%date%';

-- 15. Get 10 films with the longest title.
SELECT *
FROM film
ORDER BY length(TITLE) DESC
limit 10;

-- 16. Get 10 the longest films.
SELECT * FROM film
ORDER BY length DESC
limit 10;

-- 17. How many films include **Behind the Scenes** content?
SELECT COUNT(special_features)
FROM film
WHERE special_features LIKE '%Behind the Scenes%';

-- 18. List films ordered by release year and title in alphabetical order.
SELECT * FROM film
ORDER BY release_year AND title asc

-- 19. Drop column `picture` from `staff`.
ALTER TABLE staff
DROP COLUMN picture;

-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
insert into staff (first_name,last_name,address_id,email,store_id,active,username)
values 
("Tammy","Sanders",79,"tammy.sanders@sakilastaff.com",2,1,"Tammy");


-- 21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
--    **Hint**: Check the columns in the table rental and see what information you would need to add there. 
-- You can query those pieces of information. For eg., you would notice that you need `customer_id` information as well.
-- To get that you can use the following query:
--   ```sql
--    select customer_id from sakila.customer
--    where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
--    customer_id = 130
--    film_id = 1

insert into inventory (first_name,last_name,address_id,email,store_id,active,username)
values 
("Tammy","Sanders",79,"tammy.sanders@sakilastaff.com",2,1,"Tammy");

    Use similar method to get `inventory_id`, `film_id`, and `staff_id`.
    
select * from film where title = "Academy Dinosaur";





    








