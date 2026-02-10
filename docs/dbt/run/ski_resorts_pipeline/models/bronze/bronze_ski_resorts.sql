
  
    

create or replace transient table ski_db.staging_bronze.bronze_ski_resorts
    
    
    
    as (SELECT 
    *
FROM 
    ski_db.staging.ski_resorts
    )
;


  