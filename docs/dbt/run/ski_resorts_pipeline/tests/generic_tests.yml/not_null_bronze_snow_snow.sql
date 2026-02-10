
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select snow
from ski_db.bronze.bronze_snow
where snow is null



  
  
      
    ) dbt_internal_test