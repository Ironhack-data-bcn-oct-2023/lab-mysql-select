USE sakila;
-- 1-How many distinct (different) actors' last names are there?-
SELECT count(last_name) FROM actor;
-- 2-In how many different languages where the films originally produced? (Use the column `language_id` from the `film` table)
SELECT count(language_id) FROM film;
-- 3. How many movies were released with `"PG-13"` rating?
SELECT rating, COUNT(rating) AS ct FROM film
	WHERE rating = "PG-13";
-- 4. Get 10 the longest movies from 2006.
SELECT length FROM film LIMIT 10;
-- 5. How many days has been the company operating (check `DATEDIFF()` function)?
SELECT DATEDIFF(max(rental_date),min(rental_date)) FROM rental;
-- 6. Show rental info with additional columns month and weekday. Get 20.
SELECT *, MONTH(rental_date) AS month, DAYOFWEEK(rental_date) as week_day FROM rental LIMIT 20;
-- 7. Add an additional column `day_type` with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT*, 
    MONTH(rental_Date) AS month,
    DAYNAME(rental_date) AS week_day,
    CASE
        WHEN DAYOFWEEK(rental_date) IN (2, 3, 4, 5, 6) THEN 'workday'
        WHEN DAYOFWEEK(rental_date) IN (1 , 7) THEN 'weekend'
    END AS day_type
FROM rental;

-- 8. How many rentals were in the last month of activity? there is only one month 

SELECT COUNT(*)
FROM rental
where rental_date >= (select max(rental_date) from rental) - interval 1 month;

-- 9. Get film ratings
SELECT rating FROM film;
-- 10. Get release years.
SELECT release_year FROM film;
-- 11. Get all films with ARMAGEDDON in the title.
SELECT * FROM film WHERE title LIKE "%ARMAGEDDON%";
-- 12. Get all films with APOLLO in the title
SELECT * FROM film WHERE title LIKE "%APOLLO%";
-- 13. Get all films which title ends with APOLLO.
SELECT * FROM film WHERE title LIKE "%APOLLO";
-- 14. Get all films with word DATE in the title.
SELECT * FROM film WHERE title LIKE "%DATE%";
-- 15. Get 10 films with the longest title.
SELECT LENGTH(title) FROM film ORDER BY LENGTH(title) DESC LIMIT 10;
-- 16. Get 10 the longest films.
SELECT length FROM film ORDER BY length DESC LIMIT 10;
-- 17. How many films include **Behind the Scenes** content?
SELECT COUNT(special_features) FROM film WHERE special_features = "Behind the Scenes";
-- 18. List films ordered by release year and title in alphabetical order.
SELECT * FROM film ORDER BY release_year,title;
-- 19. Drop column `picture` from `staff`.
ALTER TABLE staff
DROP COLUMN picture;

-- 20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM staff where first_name = "Jon"; -- Store_id = 2
INSERT INTO staff(first_name, last_name, address_id,store_id,active,username,last_update) VALUES ("TAMMY","SANDERS",4,2,1,"TAMMY", '2023-10-25' );
-- 21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
-- **Hint**: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need `customer_id` information as well. To get that you can use the following query:

    select customer_id from sakila.customer
    where first_name = 'CHARLOTTE' and last_name = 'HUNTER'; -- costumer_id = 130
    select film_id from sakila.film
    where title = 'Academy Dinosaur'; -- film_id = 1
    select inventory_id from sakila.inventory
    where film_id = 1 AND store_id = 1; -- inventory_id = 1 a 4
    select staff_id from sakila.staff
    where first_name = 'Mike' and last_name = 'Hillyer'; -- staff_id = 1
  INSERT INTO rental(rental_date, inventory_id, customer_id,staff_id,last_update) VALUES ("2023-10-25",3,130,1,'2023-10-25' )  
