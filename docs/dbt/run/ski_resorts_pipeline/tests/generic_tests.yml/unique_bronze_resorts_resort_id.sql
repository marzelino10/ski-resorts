
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    resort_id as unique_field,
    count(*) as n_records

from ski_db.bronze.bronze_resorts
where resort_id is not null
group by resort_id
having count(*) > 1



  
  
      
    ) dbt_internal_test