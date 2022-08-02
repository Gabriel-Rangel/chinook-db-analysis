CREATE TABLE fact_transaction AS
SELECT  invoice_line.invoice_line_id
       ,invoice_line.invoice_id
       ,track_id
       ,unit_price
       ,quantity
       ,unit_price*quantity AS total
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