
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  SELECT 
    *
FROM
    ski_db.staging_bronze.bronze_ski_resorts
WHERE 
    latitude NOT BETWEEN -90 AND 90
    AND longitude NOT BETWEEN -180 AND 180
  
  
      
    ) dbt_internal_test