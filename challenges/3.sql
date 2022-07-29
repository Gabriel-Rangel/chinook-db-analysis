-- Qual a música mais vendida por quantidade?

CREATE VIEW vw_top_music_per_qtd AS
    SELECT 
        track_id,
        music_name,
        quantidade_vendida 
    FROM(
        SELECT 
            tr.track_id,
            tr.name as music_name,
            SUM(inli.quantity) AS quantidade_vendida,
            -- uso de windows functions criar ranking baseado no número de quantidades vendidas
            RANK() OVER(ORDER by SUM(inli.quantity) DESC) AS ranking
        FROM customer cu
        INNER JOIN invoice inv ON cu.customer_id = inv.customer_id
        INNER JOIN invoice_line inli ON inv.invoice_id = inli.invoice_id
        INNER JOIN track tr ON inli.track_id = tr.track_id 
        GROUP BY tr.track_id, tr.name
        ) base
    WHERE ranking = 1

-- ANSWER: track_id: 3336, name: War Pigs, quantidade_vendida: 31