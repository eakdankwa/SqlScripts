SELECT * 
FROM parks_and_recreation.employee_demographics;

SELECT first_name, 
last_name, 
birth_date,
age,
(age + 10) AS age_in_ten_yrs #PEMDAS
FROM parks_and_recreation.employee_demographics;

SELECT  DISTINCT first_name, gender
FROM parks_and_recreation.employee_demographics;