-- WINDOWS FUNCTIONS

SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
    GROUP BY gender;
    
    SELECT dem.first_name,dem.last_name,gender,AVG(salary) OVER(PARTITiON BY gender)
    FROM employee_demographics dem
    JOIN employee_salary sal
		ON dem.employee_id = sal.employee_id;