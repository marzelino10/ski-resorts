

WITH distinct_country AS (
    SELECT
        DISTINCT
        
        
    TRIM(
        REGEXP_REPLACE(country, '[\?�]', '') 
        )
 AS country , 
        
        
    TRIM(
        REGEXP_REPLACE(continent, '[\?�]', '') 
        )
 AS continent 
        
    FROM 
        ski_db.bronze.bronze_resorts
)

SELECT
    ROW_NUMBER() OVER (ORDER BY country, continent) AS country_id,
    country, 
    continent
FROM
    distinct_country