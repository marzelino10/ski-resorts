WITH distinct_feature AS (
    SELECT
        DISTINCT
            resort_id,
            snow_cannons,
            is_child_friendly,
            has_snowparks,
            has_nightskiing,
            has_summer_skiing
    FROM
        {{ ref("silver_resorts") }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY resort_id) AS feature_id,
    *
FROM
    distinct_feature