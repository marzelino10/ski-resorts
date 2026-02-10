WITH distinct_slope AS (    
    SELECT
        DISTINCT
            resort_id,
            beginner_slopes AS beginner_slopes_km,
            intermediate_slopes AS intermediate_slopes_km,
            difficult_slopes AS difficult_slopes_km
    FROM
        ski_db.bronze.bronze_resorts
)

SELECT
    ROW_NUMBER() OVER (ORDER BY resort_id) AS slope_id,
    *
FROM
    distinct_slope