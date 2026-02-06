WITH resort_geopoint AS (
    SELECT    
        resort_id,
        resort,
        geopoint
    FROM 
        {{ ref("silver_core_resorts") }} AS cr
    LEFT JOIN
        {{ ref("silver_core_locations") }} AS cl
    ON 
        cr.location_id = cl.location_id
),
snow_geopoint AS (
    SELECT
        month,
        snow_coverage_perc,
        geopoint
    FROM
        {{ ref("silver_core_snow") }} AS cs
    LEFT JOIN
        {{ ref("silver_core_locations") }} AS cl
    ON 
        cs.location_id = cl.location_id
)

SELECT
    resort_id,
    resort,
    month,
    AVG(snow_coverage_perc) AS avg_snow_coverage_per,
    MAX(snow_coverage_perc) AS max_snow_coverage_per,
    COUNT(snow_coverage_perc) AS snow_grid_used
FROM
    resort_geopoint AS rg
JOIN
    snow_geopoint AS sg
ON
    ST_DISTANCE(rg.geopoint, sg.geopoint) <= 30000
GROUP BY 
    month,
    resort_id,
    resort
ORDER BY 
    resort_id,
    month