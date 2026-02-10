
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  SELECT 
    *
FROM
    ski_db.bronze.bronze_snow
WHERE 
    latitude NOT BETWEEN -90 AND 90
    OR longitude NOT BETWEEN -180 AND 180
    OR snow NOT BETWEEN 0 AND 100
  
  
      
    ) dbt_internal_test