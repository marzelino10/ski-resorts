SELECT
    country,
    continent,
    COUNT(*) AS resort_count,
    AVG(ST_X(resort_geopoint)) AS country_center_lat,
    AVG(ST_Y(resort_geopoint)) AS country_center_long
FROM
    ski_db.staging_silver.silver_ski_resorts
GROUP BY
    country,
    continent