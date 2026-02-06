WITH distinct_lift AS (
    SELECT
        DISTINCT
            resort_id,
            surface_lifts,
            chair_lifts,
            gondola_lifts,
            lift_capacity
    FROM
        {{ ref("bronze_resorts")}}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY resort_id) AS lift_id,
    *
FROM distinct_lift