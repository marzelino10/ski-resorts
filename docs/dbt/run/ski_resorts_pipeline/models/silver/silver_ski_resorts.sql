
  
    

create or replace transient table ski_db.staging_silver.silver_ski_resorts
    
    
    
    as (

WITH flatten_seasons AS (
    SELECT
        resort_id,
        TRIM(S.value::string) AS resort_season
    FROM
        ski_db.staging_bronze.bronze_resorts,
        LATERAL FLATTEN(input=> SPLIT(season, ',')) S
)

SELECT 
    r.resort_id,
    
        
    TRIM(
        REGEXP_REPLACE(resort, '[\?�]', '') 
        )
 AS resort , 
    
        
    TRIM(
        REGEXP_REPLACE(country, '[\?�]', '') 
        )
 AS country , 
    
        
    TRIM(
        REGEXP_REPLACE(continent, '[\?�]', '') 
        )
 AS continent 
    ,
    longitude,
    latitude,
    price AS euro_price,
    MONTH(
        TO_DATE(
            CASE 
                WHEN TRIM(LOWER(resort_season)) = 'year-round' THEN 'January'
                WHEN LOWER(resort_season) = 'unknown' THEN NULL
                ELSE TRIM(SPLIT_PART(resort_season, '-', 1)) 
                END,
            'MMMM')
        ) AS season_start_month,
    MONTH(
        TO_DATE(
            CASE 
                WHEN TRIM(LOWER(resort_season)) = 'year-round' THEN 'December'
                WHEN LOWER(resort_season) = 'unknown' THEN NULL
                WHEN TRIM(SPLIT_PART(resort_season, '-', 2)) = '' THEN TRIM(SPLIT_PART(resort_season, '-', 1))
                ELSE TRIM(SPLIT_PART(resort_season, '-', 2)) 
                END,
            'MMMM')
        ) AS season_end_month,
    highest_point AS highest_point_m,
    lowest_point AS lowest_point_m,
    beginner_slopes AS beginner_slopes_km,
    intermediate_slopes AS intermediate_slopes_km,
    difficult_slopes AS difficult_slopes_km,
    total_slopes,
    longest_run AS longest_run_km,
    snow_cannons,
    surface_lifts,
    chair_lifts,
    gondola_lifts,
    total_lifts,
    lift_capacity,
    child_friendly,
    snowparks,
    nightskiing,
    summer_skiing
FROM 
    ski_db.staging_bronze.bronze_resorts AS r
LEFT JOIN 
    flatten_seasons AS s
ON
    r.resort_id = s.resort_id
    )
;


  