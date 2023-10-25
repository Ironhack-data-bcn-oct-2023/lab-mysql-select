USE SAKILA; 

-- 1. 
SELECT COUNT(DISTINCT (last_name)) FROM ACTOR;
-- 2. 
SELECT COUNT(DISTINCT (language_id)) FROM FILM; 
-- 3. 
SELECT COUNT(DISTINCT FILM_ID) FROM FILM WHERE RATING = "PG-13";
-- 4. 
SELECT TITLE FROM FILM 
	WHERE (RELEASE_YEAR = "2006") 
    ORDER BY LENGTH DESC
    LIMIT 10; 

-- 5. 
SELECT DATEDIFF(max(rental_date), min(rental_date)) FROM RENTAL;
-- 6.
SELECT rental_id, rental_date, staff_id, month(rental_date) as month_, weekday(rental_date) as weekday_ from RENTAL; 

-- 7. 
ALTER TABLE RENTAL
ADD day_type VARCHAR(20); 

set sql_safe_updates = 0; 


UPDATE RENTAL
SET day_type =
	CASE
		WHEN weekday(rental_date) in (1,2,3,5) then "workday" 
    ELSE "weekend"
END;

-- 8.  
SELECT COUNT(rental_id) FROM RENTAL
where month(rental_date);  
   
-- 9. 
SELECT DISTINCT(rating)from FILM;

-- 10. 
SELECT DISTINCT(release_year) from FILM;  

-- 11. 
SELECT * FROM FILM  
	WHERE TITLE LIKE ("%ARMAGEDDON%");
  
-- 12. 
SELECT * FROM FILM  
	WHERE TITLE LIKE ("%APOLLO%");
    
-- 13.    
SELECT * FROM FILM  
	WHERE TITLE LIKE ("%APOLLO");
    
-- 14.

SELECT * FROM FILM  
	WHERE TITLE REGEXP "\\bDATE\\b";

-- 15. 
SELECT * FROM FILM 
    ORDER BY LENGTH(TITLE) DESC
    LIMIT 10; 
    

-- 16. 
SELECT TITLE, LENGTH FROM FILM 
    ORDER BY LENGTH DESC
    LIMIT 10; 

-- 17. 
SELECT * FROM FILM
	WHERE SPECIAL_FEATURES LIKE ("%Behind the Scenes%");
    
-- 18.     
SELECT * FROM FILM
ORDER BY RELEASE_YEAR ASC, TITLE ASC;

-- 19.
ALTER TABLE STAFF
DROP PICTURE; 

-- 20. 
INSERT INTO staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, last_update)
SELECT customer_id, first_name, last_name, address_id, email, store_id, active, "-", last_update
FROM CUSTOMER
WHERE first_name = "TAMMY" and last_name = "SANDERS";

-- 21. 
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES("2023-10-25", 1, 130, "2023-10-31", 1, "2006-02-15 05:09:17"); 

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

select * from staff
where store_id = 1;

select * from rental
where staff_id = 1 and customer_id = 130;

select * from inventory
where film_id = 1;

select * from film 
where title like "%DINOSAUR%";


-- 22. 
CREATE TABLE deleted_users AS SELECT CUSTOMER_ID, EMAIL FROM CUSTOMER;

INSERT INTO DELETED_USERS (CUSTOMER_ID, EMAIL) 
SELECT CUSTOMER_ID, EMAIL
FROM CUSTOMER
WHERE ACTIVE = 0;

DELETE FROM CUSTOMER
WHERE active = 0;
    -- cannot delete without messing up stuff

