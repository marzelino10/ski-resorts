
  
    

create or replace transient table ski_db.bronze.bronze_snow
    
    
    
    as (SELECT 
    *
FROM 
    ski_db.staging.ski_snow
    )
;


  