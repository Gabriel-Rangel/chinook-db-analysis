CREATE TABLE dw_chinook.dim_customer AS
SELECT  customer_id
       ,first_name
       ,last_name
       ,company
       ,address
       ,city
       ,'state'
       ,country
       ,postal_code
       ,phone
       ,fax
       ,email
FROM chinook.customer;
