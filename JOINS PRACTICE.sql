-- JOINS PRACTICE;
-- INNER JOINS
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
    SELECT dem.employee_id,occupation,age
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
    -- OUTER JOINS
    SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
    
    SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
    
    -- SELF JOINS
    SELECT *
    FROM employee_salary employee1
    JOIN employee_salary employee2
		ON employee1.employee_id = employee2.employee_id;
        
        SELECT *
    FROM employee_salary employee1
    JOIN employee_salary employee2
		ON employee1.employee_id + 1 = employee2.employee_id;
        
        SELECT employee1.employee_id AS A, 
        employee1.first_name AS B,
        employee1.last_name AS C,
        employee2.employee_id AS D,
        employee2.first_name AS E,
        employee2.last_name AS F
    FROM employee_salary employee1
    JOIN employee_salary employee2
		ON employee1.employee_id + 2 = employee2.employee_id;
        
        
        -- MULTIPLE JOINS
        SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
    INNER JOIN parks_departments PD
		ON sal.dept_id = PD.department_id;
    
   
        
        
    
    
