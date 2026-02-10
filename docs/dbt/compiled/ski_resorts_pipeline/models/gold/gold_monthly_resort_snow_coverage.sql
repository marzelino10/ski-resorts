SELECT 
    r.resort_id,
    r.resort,
    r.country,
    r.continent,
    r.euro_price,
    s.month,
    s.snow_coverage_perc
FROM
    ski_db.staging_silver.silver_ski_resorts AS r
JOIN
    ski_db.staging_silver.silver_ski_snow AS s
ON ST_DISTANCE(r.resort_geopoint, s.snow_geopoint) <= 25000