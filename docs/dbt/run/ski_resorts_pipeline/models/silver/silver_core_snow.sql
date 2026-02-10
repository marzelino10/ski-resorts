
  
    

create or replace transient table ski_db.silver.silver_core_snow
    
    
    
    as (SELECT 
    month,
    location_id,
    snow AS snow_coverage_perc
FROM
    ski_db.bronze.bronze_snow AS s 
LEFT JOIN
    ski_db.silver.silver_core_locations AS cl
ON 
    s.latitude = cl.latitude
AND 
    s.longitude = cl.longitude
WHERE cl.country_id IS NULL
    )
;


  