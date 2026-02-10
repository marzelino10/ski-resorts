
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        continent as value_field,
        count(*) as n_records

    from ski_db.bronze.bronze_resorts
    group by continent

)

select *
from all_values
where value_field not in (
    'Asia','Europe','Africa','North America','South America','Oceania'
)



  
  
      
    ) dbt_internal_test