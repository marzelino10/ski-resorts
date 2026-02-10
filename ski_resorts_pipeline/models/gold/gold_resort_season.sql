WITH calendar_months AS (
    SELECT
        SEQ2() + 1 AS calendar_month
    FROM
        TABLE(GENERATOR(ROWCOUNT => 12))
)

SELECT 
    DISTINCT(resort_id),
    calendar_month,
    CASE 
        WHEN season_start_month <= season_end_month AND calendar_month BETWEEN season_start_month AND season_end_month
            THEN TRUE
        WHEN season_start_month > season_end_month AND (calendar_month >= season_start_month OR calendar_month <= season_end_month)
            THEN TRUE
        ELSE FALSE
        END AS is_operating_season,
    season_start_month,
    season_end_month
FROM
    {{ ref("silver_resorts") }}
CROSS JOIN calendar_months
ORDER BY
    resort_id,
    calendar_month