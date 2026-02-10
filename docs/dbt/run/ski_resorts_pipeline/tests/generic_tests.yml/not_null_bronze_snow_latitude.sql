
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select latitude
from ski_db.bronze.bronze_snow
where latitude is null



  
  
      
    ) dbt_internal_test