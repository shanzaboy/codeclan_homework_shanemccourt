/*Find all the employees who work in the ‘Human Resources’ department.*/

SELECT *
FROM employees 
WHERE department = 'Human Resources';


/*MVP 2*/

/*Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department.*/

SELECT
first_name,
last_name,
country 
FROM employees 
WHERE department = 'Legal';

/*MVP Qu3 Count the number of employees based in Portugal*/

SELECT
COUNT(*) AS portugal_count
FROM employees 
WHERE country = 'Portugal';

/* MVP qu4 Count the number of employees based in either Portugal or Spain.*/

SELECT
COUNT(*) AS portugal_and_spain_count
FROM employees 
WHERE country = 'Portugal' OR country = 'Spain';

/* MVP QU 5 Count the number of pay_details records lacking a local_account_no */

SELECT 
COUNT(*)
FROM pay_details 
WHERE iban IS NULL;


/* MVP Q6 Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last).*/
 
SELECT
first_name,
last_name
FROM employees 
ORDER BY last_name DESC NULLS LAST;


/* MVP Q7 How many employees have a first_name beginning with ‘F’? */

SELECT
COUNT(*)
FROM employees 
WHERE first_name LIKE 'F%';

/* MVP Q8 count the number of pension enrolled employees not based in either France or Germany */

SELECT
COUNT(*)
FROM employees 
WHERE (pension_enrol = TRUE) AND (country != 'France' OR country != 'Germany');


