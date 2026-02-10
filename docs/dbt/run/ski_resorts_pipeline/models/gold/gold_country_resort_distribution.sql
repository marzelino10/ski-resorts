
  create or replace   view ski_db.staging_gold.gold_country_resort_distribution
  
  
  
  
  as (
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
  );

