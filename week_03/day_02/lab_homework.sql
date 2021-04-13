--1 MVP


--Question 1.
/*(a). Find the first name, last name and team name of employees who are members of teams.

Hint
We only want employees who are also in the teams table. So which type of join should we use*/

SELECT 
	e.first_name,
	e.last_name,
	t.name as team_name
FROM 
	employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id;



/*(b). Find the first name, last name and team name of employees who are members of teams and are enrolled in the pension scheme.*/

SELECT 
	e.first_name,
	e.last_name,
	t.name as team_name
FROM 
	employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
WHERE pension_enrol = TRUE;



/*(c). Find the first name, last name and team name of employees who are members of teams, where their team has a charge cost greater than 80.

Hint
charge_cost may be the wrong type to compare with value 80. Can you find a way to convert it without changing the database?*/


SELECT 
	e.first_name,
	e.last_name,
	t.name as team_name,
	e.pension_enrol AS pension_enrol 
FROM 
	employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
WHERE CAST(t.charge_cost AS INTEGER) > 80;

/*Question 2.
(a). Get a table of all employees details, together with their local_account_no and local_sort_code, if they have them.

Hints
local_account_no and local_sort_code are fields in pay_details, and employee details are held in employees, so this query requires a JOIN.

What sort of JOIN is needed if we want details of all employees, even if they don’t have stored local_account_no and local_sort_code?*/





/*(b). Amend your query above to also return the name of the team that each employee belongs to.*/


SELECT
e.*,
pd.local_account_no,
pd.local_sort_code,
t.name AS team_name
FROM (employees AS e
LEFT JOIN pay_details AS pd
ON e.id = pd.id)
INNER JOIN teams AS t
ON e.team_id = t.id;

/*Hint
The name of the team is in the teams table, so we will need to do another join.

SELECT 
	e.first_name,
	e.last_name,
	t.name as team_name
FROM 
	employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
WHERE ;

*/

/*Question 3.
(a). Make a table, which has each employee id along with the team that employee belongs to.



(b). Breakdown the number of employees in each of the teams.

Hint
You will need to add a group by to the table you created above.


(c). Order the table above by so that the teams with the least employees come first.*/

SELECT
	COUNT(t.id) AS no_id
FROM 
	employees AS emp
LEFT JOIN teams AS t
ON emp.team_id = t.id
GROUP BY t.id;

SELECT 
COUNT(t.id) AS no_id,
t.name AS team_name
FROM employees AS e
LEFT JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.id;

SELECT 
COUNT(t.id) AS no_id,
t.name AS team_name
FROM employees AS e
LEFT JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.id
ORDER BY no_id ASC;

/*Question 4.
(a). Create a table with the team id, team name and the count of the number of employees in each team.*/

SELECT 
t.id,
COUNT(t.id) AS no_id,
t.name AS team_name
FROM employees AS e
LEFT JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.id
;

/*(b). The total_day_charge of a team is defined as the charge_cost of the team multiplied by the number of employees in the team. Calculate the total_day_charge for each team.

Hint
If you GROUP BY teams.id, because it’s the primary key, you can SELECT any other column of teams that you want (this is an exception 
to the rule that normally you can only SELECT a column that you GROUP BY).
*/


SELECT 
	t.id AS team_id,
	t.name AS team_name,
	COUNT(t.id) AS no_members,
	t.charge_cost AS charge_cost,
	COUNT(t.id) * CAST(t.charge_cost AS INTEGER) AS final_cost 
FROM 
	employees AS emp
LEFT JOIN teams AS t
ON emp.team_id = t.id
GROUP BY t.id
ORDER BY no_members;

/*(c). How would you amend your query from above to show only those teams with a total_day_charge greater than 5000?*/

SELECT *
FROM (
	SELECT 
		t.id AS team_id,
		t.name AS team_name,
		COUNT(t.id) AS no_members,
		t.charge_cost AS charge_cost,
		COUNT(t.id) * CAST(t.charge_cost AS INTEGER) AS final_cost 
	FROM 
		employees AS emp
	LEFT JOIN teams AS t
	ON emp.team_id = t.id
	GROUP BY t.id
	ORDER BY no_members) AS charge_table
WHERE charge_table.final_cost > 5000;

/*Question 5.
How many of the employees serve on one or more committees?


Hints
All of the details of membership of committees is held in a single table: employees_committees, so this doesn’t require a join.

Some employees may serve in multiple committees. Can you find the number of distinct employees who serve? [Extra hint - do some research on the DISTINCT() function].*/


SELECT 
	t.id AS team_id,
	t.name AS team_name,
	COUNT(t.id) AS no_members,
	t.charge_cost AS charge_cost,
	COUNT(t.id) * CAST(t.charge_cost AS INTEGER) AS final_cost 
FROM 
	employees AS emp
LEFT JOIN teams AS t
ON emp.team_id = t.id
GROUP BY t.id
ORDER BY no_members;








/*Question 6.
How many of the employees do not serve on a committee?


Hints
This requires joining over only two tables

Could you use a join and find rows without a match in the join?*/

