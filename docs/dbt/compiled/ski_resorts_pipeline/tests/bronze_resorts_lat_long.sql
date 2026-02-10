SELECT 
    *
FROM
    ski_db.bronze.bronze_resorts
WHERE 
    latitude NOT BETWEEN -90 AND 90
    AND longitude NOT BETWEEN -180 AND 180