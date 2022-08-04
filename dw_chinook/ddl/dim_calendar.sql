CREATE TABLE dw_chinook.dim_calendar AS
SELECT   d                     AS "date"
       , extract(day FROM d)   AS "day" 
       , extract(month FROM d) AS "month" 
       , extract(year FROM d)  AS "year" 
       , to_char(d, 'Day')     AS week_day 
FROM
(
	SELECT  cast(generate_series(date '2017-01-01',date '2020-12-31','1 day') AS date) AS d
) base
