SELECT 
    month,
    location_id,
    snow AS snow_coverage_perc
FROM
    {{ ref("bronze_snow") }} AS s 
LEFT JOIN
    {{ ref("silver_core_locations") }} AS cl
ON 
    s.latitude = cl.latitude
AND 
    s.longitude = cl.longitude
WHERE cl.country_id IS NULL