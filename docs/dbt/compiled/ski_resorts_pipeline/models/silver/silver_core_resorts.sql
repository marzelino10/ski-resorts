WITH flatten_seasons AS (
    SELECT
        resort_id,
        TRIM(S.value::string) AS resort_season
    FROM
        ski_db.bronze.bronze_resorts,
        LATERAL FLATTEN(input=> SPLIT(season, ',')) S
)

SELECT 
    r.resort_id,
    
    TRIM(
        REGEXP_REPLACE(resort, '[\?�]', '') 
        )
 AS resort,
    location_id,
    price AS euro_price,
    MONTH(
            TO_DATE(
                CASE 
                    WHEN TRIM(LOWER(resort_season)) = 'year-round' THEN 'January'
                    WHEN LOWER(resort_season) = 'unknown' THEN NULL
                    ELSE TRIM(SPLIT_PART(resort_season, '-', 1)) 
                    END,
                'MMMM')
            ) AS season_start_month,
        MONTH(
            TO_DATE(
                CASE 
                    WHEN TRIM(LOWER(resort_season)) = 'year-round' THEN 'December'
                    WHEN LOWER(resort_season) = 'unknown' THEN NULL
                    WHEN TRIM(SPLIT_PART(resort_season, '-', 2)) = '' THEN TRIM(SPLIT_PART(resort_season, '-', 1))
                    ELSE TRIM(SPLIT_PART(resort_season, '-', 2)) 
                    END,
                'MMMM')
            ) AS season_end_month,
    terrain_id,
    slope_id,
    lift_id,
    feature_id
FROM 
    ski_db.bronze.bronze_resorts AS r
LEFT JOIN
    flatten_seasons AS fs
    ON r.resort_id = fs.resort_id
LEFT JOIN
    ski_db.silver.silver_core_locations AS cl
    ON 
        r.latitude = cl.latitude
    AND r.longitude = cl.longitude
LEFT JOIN
    ski_db.silver.silver_core_terrain AS ct
    ON
        r.resort_id = ct.resort_id
LEFT JOIN
    ski_db.silver.silver_core_slopes AS cs
    ON
        r.resort_id = cs.slope_id
LEFT JOIN
    ski_db.silver.silver_core_lifts AS cli
    ON
        r.resort_id = cli.resort_id
LEFT JOIN
    ski_db.silver.silver_core_features AS cf
    ON
        r.resort_id = cf.resort_id
ORDER BY 
    r.resort_id