SELECT 
    *
FROM
    {{ ref('bronze_snow') }}
WHERE 
    latitude NOT BETWEEN -90 AND 90
    OR longitude NOT BETWEEN -180 AND 180
    OR snow NOT BETWEEN 0 AND 100