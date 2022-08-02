CREATE TABLE dim_employee AS
SELECT  employee_id
       ,first_name
       ,last_name
       ,title
       ,reports_to
       ,birthdate
       ,hire_date
       ,address
       ,city
       ,'state'
       ,country
       ,postal_code
       ,phone
       ,fax
       ,email
FROM chinook.employee;