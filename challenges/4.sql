-- Qual a música mais vendida por valor ?

CREATE VIEW vw_top_music_per_value AS
    SELECT 
        track_id,
        music_name,
        valor_vendido 
    FROM(
        SELECT 
            tr.track_id,
            tr.name as music_name,
            SUM(inli.unit_price) AS valor_vendido,
            -- uso de windows functions criar ranking baseado no valor vendido de cada track
            RANK() OVER(ORDER by SUM(inli.unit_price) DESC) AS ranking
        FROM customer cu
        INNER JOIN invoice inv ON cu.customer_id = inv.customer_id
        INNER JOIN invoice_line inli ON inv.invoice_id = inli.invoice_id
        INNER JOIN track tr ON inli.track_id = tr.track_id 
        GROUP BY tr.track_id, tr.name
        ) base
    where ranking = 1

-- ANSWER: track_id: 3336, name: War Pigs, valor_vendido: 30.69