-- Qual gênero vende mais quantidade e valor por cidade/estado/país - se houver empate em valor, trazer todos.

-- primeira query traz o gênero mais vendido por país.
CREATE VIEW vw_top_genre_per_country AS
    SELECT 
        country,
        genero
    FROM(
        SELECT 
            SUM(inli.unit_price) AS valor_vendido, 
            SUM(inli.quantity) AS quantidade_vendida,
            cu.country,
            ge.name AS genero,
            -- uso de windows functions para agrupar por cidade
            RANK() OVER(PARTITION BY cu.country ORDER by SUM(inli.unit_price) DESC, SUM(inli.quantity) DESC) AS ranking
        FROM customer cu
        INNER JOIN invoice inv ON cu.customer_id = inv.customer_id
        INNER JOIN invoice_line inli ON inv.invoice_id = inli.invoice_id
        INNER JOIN track tr ON inli.track_id = tr.track_id 
        INNER JOIN genre ge ON tr.genre_id = ge.genre_id
        GROUP by cu.country, ge.name
        ) base
    WHERE ranking = 1
;

-- segunda query traz o gênero mais vendido por estado.
CREATE VIEW vw_top_genre_per_state AS
    SELECT 
        state,
        genero
    FROM(
        SELECT 
            SUM(inli.unit_price) AS valor_vendido, 
            SUM(inli.quantity) AS quantidade_vendida,
            cu.state,
            ge.name AS genero,
            -- uso de windows functions para agrupar por cidade
            RANK() OVER(PARTITION BY cu.state ORDER by SUM(inli.unit_price) DESC, SUM(inli.quantity) DESC) AS ranking
        FROM customer cu
        INNER JOIN invoice inv ON cu.customer_id = inv.customer_id
        INNER JOIN invoice_line inli ON inv.invoice_id = inli.invoice_id
        INNER JOIN track tr ON inli.track_id = tr.track_id 
        INNER JOIN genre ge ON tr.genre_id = ge.genre_id
        GROUP by cu.state, ge.name
        ) base
    WHERE 
        ranking = 1 
        AND state IS NOT NULL
;

-- terceira query traz o gênero mais vendido por cidade
CREATE VIEW vw_top_genre_per_city AS
    SELECT 
        city,
        genero
    FROM(
        SELECT 
            SUM(inli.unit_price) AS valor_vendido, 
            SUM(inli.quantity) AS quantidade_vendida,
            cu.city,
            ge.name AS genero,
            -- uso de windows functions para agrupar por cidade
            RANK() OVER(PARTITION BY cu.city ORDER by SUM(inli.unit_price) DESC, SUM(inli.quantity) DESC) AS ranking
        FROM customer cu
        INNER JOIN invoice inv ON cu.customer_id = inv.customer_id
        INNER JOIN invoice_line inli ON inv.invoice_id = inli.invoice_id
        INNER JOIN track tr ON inli.track_id = tr.track_id 
        INNER JOIN genre ge ON tr.genre_id = ge.genre_id
        GROUP by cu.city, ge.name
        ) base
    WHERE ranking = 1;