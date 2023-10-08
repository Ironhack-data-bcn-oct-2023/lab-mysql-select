![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# Lab | mySQL Regex

In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals. You have been using this database for a couple labs already, but if you need to get the data again, refer to the official [installation link](https://dev.mysql.com/doc/sakila/en/sakila-installation.html).

The database is structured as follows:
![DB schema](https://education-team-2020.s3-eu-west-1.amazonaws.com/data-analytics/database-sakila-schema.png)

<br><br>

### Submission

Create a `.sql` file where you'll gather your responses. Either copy them as you test them on workbench or code them and File > Save script.

### Instructions

1. How many distinct (different) actors' last names are there?
2. In how many different languages where the films originally produced? (Use the column `language_id` from the `film` table)
3. How many movies were released with `"PG-13"` rating?
4. Get 10 the longest movies from 2006.
5. How many days has been the company operating (check `DATEDIFF()` function)?
6. Show rental info with additional columns month and weekday. Get 20.
7. Add an additional column `day_type` with values 'weekend' and 'workday' depending on the rental day of the week.
8. How many rentals were in the last month of activity?

9. Get film ratings.
10. Get release years.
11. Get all films with ARMAGEDDON in the title.
12. Get all films with APOLLO in the title
13. Get all films which title ends with APOLLO.
14. Get all films with word DATE in the title.
15. Get 10 films with the longest title.
16. Get 10 the longest films.
17. How many films include **Behind the Scenes** content?
18. List films ordered by release year and title in alphabetical order.

19. Drop column `picture` from `staff`.
20. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
21. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the `rental_date` column in the `rental` table.
    **Hint**: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need `customer_id` information as well. To get that you can use the following query:

    ```sql
    select customer_id from sakila.customer
    where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
    ```

    Use similar method to get `inventory_id`, `film_id`, and `staff_id`.

22. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

    - Check if there are any non-active users
    - Create a table _backup table_ as suggested
    - Insert the non active users in the table _backup table_
    - Delete the non active users from the table _customer_
