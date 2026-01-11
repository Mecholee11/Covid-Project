-- STRING FUNCTIONS

SELECT LENGTH('ICE');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2;

SELECT UPPER('sky');
SELECT LOWER('SKY');

SELECT first_name, UPPER(first_name)
FROM employee_demographics
ORDER BY 2;

SELECT RTRIM('        Ice                 ');

SELECT first_name,
 LEFT(first_name, 4),
 RIGHT(first_name, 4),
SUBSTRING(first_name,3,2),
 birth_date,
 SUBSTRING(birth_date,6,5) AS birth_month
FROM employee_demographics;

SELECT first_name, REPLACE(first_name,'e','r')
FROM employee_demographics;

SELECT LOCATE('L', 'Samuel');

SELECT first_name, LOCATE('Be',first_name)
FROM employee_demographics;

SELECT first_name, LOCATE('Be',first_name)
FROM employee_demographics;

SELECT first_name,first_name,last_name,
CONCAT(first_name,'      ',last_name) AS full_name
FROM employee_demographics;



