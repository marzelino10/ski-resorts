
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select longitude
from ski_db.bronze.bronze_snow
where longitude is null



  
  
      
    ) dbt_internal_test