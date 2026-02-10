
  
    

create or replace transient table ski_db.silver.silver_features
    
    
    
    as (WITH distinct_feature AS (
    SELECT
        DISTINCT
            resort_id,
            snow_cannons,
            child_friendly AS is_child_friendly,
            snowparks AS has_snowparks,
            nightskiing AS has_nightskiing,
            summer_skiing AS has_summer_skiing
    FROM
        ski_db.bronze.bronze_resorts
)

SELECT
    ROW_NUMBER() OVER (ORDER BY resort_id) AS feature_id,
    *
FROM
    distinct_feature
    )
;


  