
  
    

create or replace transient table ski_db.silver.silver_terrains
    
    
    
    as (WITH distinct_terrain AS (
    SELECT
        DISTINCT
            resort_id,
            lowest_point AS lowest_point_m,
            highest_point AS highest_point_m,
            longest_run AS longest_run_km
    FROM
        ski_db.bronze.bronze_resorts
)

SELECT
    ROW_NUMBER() OVER (ORDER BY resort_id) AS terrain_id,
    *
FROM
    distinct_terrain
    )
;


  