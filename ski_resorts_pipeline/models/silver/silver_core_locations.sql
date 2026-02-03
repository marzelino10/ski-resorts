WITH distinct_location AS (
    SELECT
        DISTINCT
            latitude,
            longitude,
            country
    FROM 
        {{ ref("silver_resorts") }}
),
countries_with_id AS (
    SELECT
        latitude,
        longitude,
        country_id
    FROM
        distinct_location AS dl
    LEFT JOIN 
        {{ ref("silver_core_countries") }} AS c
    ON
        dl.country = c.country
)

SELECT
    ROW_NUMBER() OVER (ORDER BY country_id, latitude, longitude) AS location_id,
    country_id,
    latitude,
    longitude
FROM
    countries_with_id