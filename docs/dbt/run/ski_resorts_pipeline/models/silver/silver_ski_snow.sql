
  
    

create or replace transient table ski_db.staging_silver.silver_ski_snow
    
    
    
    as (SELECT 
    ROW_NUMBER() OVER (ORDER BY month, latitude, longitude) AS snow_id,
    month,
    ST_MAKEPOINT(longitude, latitude) AS snow_geopoint,
    snow AS snow_coverage_perc
FROM
    ski_db.staging_bronze.bronze_snow
    )
;


  