WITH distinct_country AS (
    SELECT
        DISTINCT
            country,
            continent
    FROM 
        {{ ref("silver_resorts")}}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY country, continent) AS country_id,
    country, 
    continent
FROM
    distinct_country