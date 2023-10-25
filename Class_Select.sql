USE publications; -- schema
SELECT  * -- 1. COLUMNS
	FROM authors;  -- 2. TABLE
    
SELECT au_id, phone, city -- 1. Columns
	FROM authors; -- 2. table
    
SELECT au_id AS ID, phone, city
	FROM authors; -- It changes in the "print"
				  -- Result set
                  
     
SELECT au_id AS ID, phone AS telefono, city
	FROM authors;    
    
-- Choosing what columns
-- Choose columns based on the rows: filter
​
SELECT au_lname, au_fname, city
FROM authors
	WHERE city = "Oakland";
    
-- WHERE: filter. Marjorie
SELECT au_lname, au_fname, city
FROM authors
	WHERE city = "Oakland" 
	AND au_fname = "Marjorie";
    
-- Oakland or SF
SELECT au_lname, au_fname, city
	FROM authors
	WHERE city = "Oakland" OR city = "San Francisco";
    
SELECT *  
FROM authors
	WHERE city = "Oakland" OR city = "San Francisco";
​
-- You can filter by something
-- even if you're not selecting that something
SELECT au_lname, au_fname
	FROM authors
	WHERE city = "Oakland" OR city = "San Francisco";
​
-- Q: All columns but one
SELECT au_lname, au_fname, phone, address, city, state,
zip, contract
	FROM authors;
    
-- Multiple conditions
-- business AND price > 20
-- OR pyschology
​
-- titles
-- "Expensive-ish business " or psychology (no matter the price)
SELECT * 
	FROM titles
    WHERE (price > 10
		AND type = "business")
    OR type = "psychology";
-- without parenthesis
SELECT * 
	FROM titles
    WHERE price > 10
		AND type = "business"
    OR type = "psychology";
​
-- Business AND psych IF price for either is > 10
SELECT * 
	FROM titles
    WHERE price > 10
		AND (type = "business"
    OR type = "psychology");
​
-- employees
-- 1. Import employees
-- 2. New: employees
USE employees;
SELECT * from salaries;
​
SELECT * FROM employees;
-- All the women
SELECT * 
	FROM employees 
	WHERE gender = "F";
    
-- W,Nevin
​
SELECT * 
	FROM employees 
	WHERE gender = "F"
    AND FIRST_NAME = "Nevin";
​
-- Uppercase when filtering
-- SQL: NOT case-sensitive for syntaz and filterng
-- MySQL
​
SElECT * 
	from employees 
	wHErE geNdeR = "f"
    AND FIRST_NAME = "NEVIN";
    
SELECT * FROM employees; -- readability
​
-- Men named Bezalel
-- Or just women
SELECT * FROM employees
	WHERE 
		(first_name = "Bezalel"
		AND gender = "M")
	OR gender = "F";
​
-- Q: MEN named Bezalel or Women born after 1989
SELECT * FROM employees
	WHERE 
		(first_name = "Bezalel"
		AND gender = "M")
	OR gender = "F";
    
-- Men: "Hugo", "Ramzi", "Mark"
SELECT * 
FROM employees
WHERE gender = "M"
AND FIRST_NAME 
	IN ("Hugo", "Ramzi", "Mark");
    
-- Excluding names
SELECT * 
FROM employees
WHERE gender = "M"
AND FIRST_NAME 
	NOT IN ("Hugo", "Ramzi", "Mark");
​
-- Similiar "Patricia" "Patricio"
SELECT * 
	FROM employees
    WHERE first_name 
    LIKE ("Patrici_"); -- _ one of anything
    
-- Regex: REGEXP 
select * from employees
where gender = "F";
-- where first_name = "Anneke";
​
​
-- Names that start with Ann
	-- Anneke, Annemarie, Anneli, etc
    
SELECT * FROM employees
Where gender = "f" 
and first_name LIKE ("ann%"); -- % regex: .*
​
-- Q: what if I want to literally look for 
-- an underscore: you need to escape the character
-- we do that using:[_] (Uri)
​
select * from employees;
​
-- Everyone born in the 60s
SELECT * FROM employees
	WHERE birth_date LIKE ("196%"); -- 1964-06-02
​
-- Q: can we put between?
SELECT * FROM employees
	WHERE birth_date 
		BETWEEN "1960-01-01" AND "1989-12-31"; -- including (confirmed)
​
-- input the years "1990", between works with date type
-- it also works with something else
​
SELECT * FROM employees
WHERE first_name BETWEEN "A" AND "C"; -- between 
​
-- A-C: A and b (C is not included)
​
-- All the women hired in the 90s
SELECT * 
	FROM employees
    WHERE hire_date LIKE ("199%")
    AND gender = "F";
​
-- $145,732
​
SELECT * FROM salaries
	where salary >= 70000;
    
-- 70-80 range
​
SELECT * FROM salaries
	WHERE salary BETWEEN 70000 AND 80000; -- Included
    
SELECT * FROM salaries
	WHERE salary BETWEEN 70000 AND 80000
ORDER BY salary;
​
SELECT * FROM salaries
	WHERE salary BETWEEN  70000 AND 80000
ORDER BY salary ASC; -- default
​
SELECT * FROM salaries
	WHERE salary BETWEEN 70000 AND 80000
ORDER BY salary DESC;
​
-- Average salary for this database :( 
SELECT AVG(salary) 
	FROM salaries;
    -- $63,810.74
    
-- Total amount of salaries pasid by the company
SELECT SUM(salary) 
	FROM salaries;
	-- 181480757419
    
-- How many employees?
SELECT COUNT(*) FROM employees; -- 300027
SELECT COUNT(first_name) FROM employees; -- 300027
​
SELECT COUNT(*) from salaries; -- 2844047
​
SELECT * FROM salaries
	WHERE salary IS NOT NULL;
​
SELECT * FROM employees
	WHERE first_name IS  NULL; -- db is ok
    
-- Salaries
-- IRPF (taxes), 15%
-- after_tax
-- gross, after_tax = salary * 0.85
select * from salaries;
​
SELECT salary AS gross, 
	(salary * 0.85) AS worker_gets,
    (salary * 1.5) AS company_spends
FROM salaries
ORDER BY company_spends DESC; -- asc is the default
​
-- Table salaries
-- Table employees
​
SELECT salary AS gross, 
	(salary * 0.85) AS worker_gets,
    (salary * 1.5) AS company_spends
FROM salaries
ORDER BY company_spends DESC;
​
​
SELECT first_name, salary, gender 
	FROM salaries
		JOIN employees
			ON	employees.emp_no = salaries.emp_no; 
-- Joining tables
SELECT AVG(salary) as mean_salary, gender 
	FROM salaries
		JOIN employees
			ON	employees.emp_no = salaries.emp_no
	GROUP BY gender;