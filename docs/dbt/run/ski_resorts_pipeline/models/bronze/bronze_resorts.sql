
  
    

create or replace transient table ski_db.bronze.bronze_resorts
    
    
    
    as (SELECT 
    *
FROM 
    ski_db.staging.ski_resorts
    )
;


  