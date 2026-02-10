
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select continent
from ski_db.bronze.bronze_resorts
where continent is null



  
  
      
    ) dbt_internal_test