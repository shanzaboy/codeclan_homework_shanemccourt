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
ORDER BY last_name ASC NULLS LAST;


/* MVP Q7 How many employees have a first_name beginning with ‘F’? */

SELECT
COUNT(*)
FROM employees 
WHERE first_name LIKE 'F%';

/* MVP Q8 count the number of pension enrolled employees not based in either France or Germany */

SELECT
COUNT(id)
FROM employees 
WHERE pension_enrol IS TRUE AND country NOT IN ('France', 'Germany');

/*//* EXtension The corporation wants to make name badges for a forthcoming conference. Return a column badge_label showing employees’ */
 *//*first_name and last_name joined together with their department in the following style: ‘Bob Smith - Legal’. Restrict output to only */
/*those employees with stored first_name, last_name and department*/

SELECT
CONCAT (first_name, ' ' ,last_name, ' - ', department)
FROM employees
WHERE first_name IS NOT NULL 
AND last_name IS NOT NULL 
AND department IS NOT NULL;


SELECT
  first_name,
  last_name,
  department,
  start_date,
  CONCAT(
    first_name, ' ', last_name, ' - ', department, 
    ' (joined ', EXTRACT(YEAR FROM start_date), ')'
  ) AS badge_label
FROM employees
WHERE 
  first_name IS NOT NULL AND 
  last_name IS NOT NULL AND 
  department IS NOT NULL AND
  start_date IS NOT NULL;

