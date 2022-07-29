-- Qual gênero vende mais quantidade e valor - se houver empate em valor, trazer todos
CREATE VIEW top_genre AS
    SELECT 
        SUM(inli.unit_price) AS valor_vendido, 
        SUM(inli.quantity) AS quantidade_vendida,
        ge.name AS genero
    FROM
        invoice_line inli
    INNER JOIN track tr ON inli.track_id = tr.track_id 
    INNER JOIN genre ge ON tr.genre_id = ge.genre_id
    GROUP by ge.name
    ORDER by valor_vendido DESC, quantidade_vendida DESC
    LIMIT 1;

-- Answer: valor: 2608.05 , quantidade: 2635 , genero: Rock 