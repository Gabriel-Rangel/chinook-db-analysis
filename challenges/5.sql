-- Qual a cidade/estado/país indicada para um show de um gênero X de música ?

-- primeira query traz o gênero mais vendido por país.
CREATE FUNCTION indicate_genre_per_country(genero VARCHAR)
RETURNS TABLE (country VARCHAR , genre VARCHAR) 
AS $$
BEGIN
	RETURN QUERY
	SELECT  
        base.country,
        base.genre
    FROM(
        SELECT 
            SUM(inli.unit_price) AS valor_vendido, 
            SUM(inli.quantity) AS quantidade_vendida,
            cu.country,
            ge.name AS genre,
            -- uso de windows functions para agrupar por cidade
            RANK() OVER(PARTITION BY ge.name ORDER by SUM(inli.unit_price) DESC, SUM(inli.quantity) DESC) AS ranking
        FROM customer cu
        INNER JOIN invoice inv ON cu.customer_id = inv.customer_id
        INNER JOIN invoice_line inli ON inv.invoice_id = inli.invoice_id
        INNER JOIN track tr ON inli.track_id = tr.track_id 
        INNER JOIN genre ge ON tr.genre_id = ge.genre_id
        WHERE ge.name = genero
        GROUP by ge.name, cu.country
        ) base
    WHERE ranking = 1;
END;
$$ LANGUAGE plpgsql;

-- segunda query traz o gênero mais vendido por estado.
CREATE FUNCTION indicate_genre_per_state(genero VARCHAR)
RETURNS TABLE ('state' VARCHAR , genre VARCHAR) 
AS $$
BEGIN
	RETURN QUERY
    SELECT 
        base.state,
        base.genre
    FROM(
        SELECT 
            SUM(inli.unit_price) AS valor_vendido, 
            SUM(inli.quantity) AS quantidade_vendida,
            cu.state,
            ge.name AS genre,
            -- uso de windows functions para agrupar por genero
            RANK() OVER(PARTITION BY ge.name ORDER by SUM(inli.unit_price) DESC, SUM(inli.quantity) DESC) AS ranking
        FROM customer cu
        INNER JOIN invoice inv ON cu.customer_id = inv.customer_id
        INNER JOIN invoice_line inli ON inv.invoice_id = inli.invoice_id
        INNER JOIN track tr ON inli.track_id = tr.track_id 
        INNER JOIN genre ge ON tr.genre_id = ge.genre_id
        WHERE ge.name = genero
        AND cu.state IS NOT NULL
        GROUP by ge.name, cu.country
        ) base
    WHERE ranking = 1;
END;
$$ LANGUAGE plpgsql;
;


-- terceira query traz o gênero mais vendido por cidade
CREATE FUNCTION indicate_genre_per_city(genero VARCHAR)
RETURNS TABLE (city VARCHAR , genre VARCHAR) 
AS $$
BEGIN
	RETURN QUERY
    SELECT 
        base.city,
        base.genre
    FROM(
        SELECT 
            SUM(inli.unit_price) AS valor_vendido, 
            SUM(inli.quantity) AS quantidade_vendida,
            cu.city,
            ge.name AS genre,
            -- uso de windows functions para agrupar por cidade
            RANK() OVER(PARTITION BY ge.name ORDER by SUM(inli.unit_price) DESC, SUM(inli.quantity) DESC) AS ranking
        FROM customer cu
        INNER JOIN invoice inv ON cu.customer_id = inv.customer_id
        INNER JOIN invoice_line inli ON inv.invoice_id = inli.invoice_id
        INNER JOIN track tr ON inli.track_id = tr.track_id 
        INNER JOIN genre ge ON tr.genre_id = ge.genre_id
        WHERE ge.name = genero
        GROUP by ge.name, cu.city
        ) base
    WHERE ranking = 1;
END;
$$ LANGUAGE plpgsql;
;








