-- dw_chinook is the collection of fact and dimensions tables where the datawarehouse is logical organized.
-- chinook is the collection of tables that contains the original transactional database.
CREATE TABLE dw_chinook.fact_transaction AS
SELECT  invoice_line.invoice_line_id
       ,invoice_line.invoice_id
       ,track_id
       ,unit_price
       ,quantity
       -- the column total in this table represents the total of the invoice line and not the total of an invoice
       ,unit_price*quantity AS total
       -- to get the total of an invoice it is needed to sum the column total for every same invoice_id
       ,invoice.customer_id
       ,support_rep_id      AS employee_id
       ,CAST(invoice_date AS DATE) AS invoice_date
       ,billing_address
       ,billing_city
       ,billing_state
       ,billing_country
       ,billing_postal_code
FROM chinook.invoice
INNER JOIN chinook.invoice_line
ON chinook.invoice.invoice_id = chinook.invoice_line.invoice_id
INNER JOIN chinook.customer
ON chinook.invoice.customer_id = chinook.customer.customer_id;
