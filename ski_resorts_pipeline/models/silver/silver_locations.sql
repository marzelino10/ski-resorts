WITH distinct_countries AS (
    SELECT
        DISTINCT
            country,
            latitude,
            longitude
    FROM
        {{ ref("bronze_resorts") }}
),
countries_with_id AS (
    SELECT
        country_id,
        latitude,
        longitude
    FROM
        distinct_countries AS dc
    LEFT JOIN
        {{ ref("silver_countries") }} AS cc
    ON
        dc.country = cc.country
),
distinct_snow_locations AS (
    SELECT
        DISTINCT
            latitude,
            longitude
    FROM
        {{ ref("bronze_snow") }}
),
combined_locations AS (
    SELECT 
        *
    FROM
        countries_with_id
    UNION
    SELECT
        NULL AS country_id,
        latitude,
        longitude
    FROM
        distinct_snow_locations
)


SELECT
    ROW_NUMBER() OVER (ORDER BY country_id, latitude, longitude) AS location_id,
    country_id,
    latitude,
    longitude,
    ST_MAKEPOINT(longitude, latitude) AS geopoint
FROM
    combined_locations