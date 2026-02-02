SELECT 
    {# MAX(latitude), MAX(longitude), MIN(latitude), MIN(longitude) #}
    {# DISTINCT(country) #}
    {# DISTINCT(continent) #}
    {# DISTINCT(season) #}
    *
FROM 
    {{ ref('bronze_ski_snow')}}
WHERE
    latitude = 63.125 AND longitude = 73.875