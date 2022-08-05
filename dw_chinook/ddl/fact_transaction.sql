-- dw_chinook is the collection of fact and dimensions tables where the datawarehouse is logical organized.
-- chinook is the collection of tables that contains the original transactional database.

CREATE TABLE dw_chinook.fact_transaction AS
SELECT  invoice_line.invoice_line_id
       ,invoice_line.invoice_id
       ,invoice_line.track_id
       ,invoice_line.unit_price
       ,invoice_line.quantity
       -- the column total in this table represents the total of the invoice line and not the total of an invoice
       ,invoice_line.unit_price*invoice_line.quantity   AS total
       -- to get the total of an invoice it is needed to sum the column total for every same invoice_id
       ,invoice.customer_id
       ,customer.support_rep_id                         AS employee_id
       ,CAST(invoice.invoice_date AS DATE)              AS "date"
       ,invoice.billing_address
       ,invoice.billing_city
       ,invoice.billing_state
       ,invoice.billing_country
       ,invoice.billing_postal_code
FROM chinook.invoice
INNER JOIN chinook.invoice_line
ON chinook.invoice.invoice_id = chinook.invoice_line.invoice_id
INNER JOIN chinook.customer
ON chinook.invoice.customer_id = chinook.customer.customer_id;
