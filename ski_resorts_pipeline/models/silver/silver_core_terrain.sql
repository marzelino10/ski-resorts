WITH distinct_terrain AS (
    SELECT
        DISTINCT
            resort_id,
            lowest_point_m,
            highest_point_m,
            longest_run_km
    FROM
        {{ ref("silver_resorts") }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY resort_id) AS terrain_id,
    *
FROM
    distinct_terrain