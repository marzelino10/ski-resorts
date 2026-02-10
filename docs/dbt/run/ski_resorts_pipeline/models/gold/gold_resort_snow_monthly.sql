
  create or replace   view ski_db.staging_gold.gold_resort_snow_monthly
  
  
  
  
  as (
    WITH resort_geopoint AS (
    SELECT    
        resort_id,
        resort,
        season_start_month,
        season_end_month
        geopoint
    FROM 
        ski_db.staging_silver.silver_core_resorts AS cr
    LEFT JOIN
        ski_db.staging_silver.silver_core_locations AS cl
    ON 
        cr.location_id = cl.location_id
),
snow_geopoint AS (
    SELECT
        month,
        snow_coverage_perc,
        geopoint
    FROM
        ski_db.staging_silver.silver_core_snow AS cs
    LEFT JOIN
        ski_db.staging_silver.silver_core_locations AS cl
    ON 
        cs.location_id = cl.location_id
)

SELECT
    resort_id,
    resort,
    season_start_month,
    season_end_month,
    month AS snow_month,
    AVG(snow_coverage_perc) AS avg_snow_coverage_per,
    MAX(snow_coverage_perc) AS max_snow_coverage_per,
    MIN(snow_coverage_perc) AS min_snow_coverage_per,
    COUNT(snow_coverage_perc) AS snow_grid_used
FROM
    resort_geopoint AS rg
JOIN
    snow_geopoint AS sg
ON
    ST_DISTANCE(rg.geopoint, sg.geopoint) <= 30000
GROUP BY 
    resort_id,
    resort,
    season_start_month,
    season_end_month,
    month
ORDER BY resort_id, snow_month
  );

