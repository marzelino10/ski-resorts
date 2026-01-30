{# WIP #}
SELECT 
    *
FROM 
    {{ ref('bronze_ski_resorts')}}
WHERE 
    resort LIKE '%?%'