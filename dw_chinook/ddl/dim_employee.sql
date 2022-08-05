-- dw_chinook is the collection of fact and dimensions tables where the datawarehouse is logical organized.
-- chinook is the collection of tables that contains the original transactional database.
CREATE TABLE dw_chinook.dim_employee AS
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
