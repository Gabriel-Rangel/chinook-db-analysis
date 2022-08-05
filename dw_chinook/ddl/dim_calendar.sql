-- dw_chinook is the collection of fact and dimensions tables where the datawarehouse is logical organized.

CREATE TABLE dw_chinook.dim_calendar AS
SELECT   d                     AS "date"
       , extract(day FROM d)   AS "day" 
       , extract(month FROM d) AS "month" 
       , extract(year FROM d)  AS "year" 
       , to_char(d, 'Day')     AS week_day 
FROM
(
	-- interval of range of dates based on max and min dates of orginal transactional database
	SELECT  cast(generate_series(date '2017-01-01',date '2020-12-31','1 day') AS date) AS d 
) base
