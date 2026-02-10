
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select resort_id
from ski_db.staging_bronze.bronze_ski_resorts
where resort_id is null



  
  
      
    ) dbt_internal_test