
    
    

select
    resort_id as unique_field,
    count(*) as n_records

from ski_db.staging_bronze.bronze_ski_resorts
where resort_id is not null
group by resort_id
having count(*) > 1


