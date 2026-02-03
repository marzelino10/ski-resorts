{% set string_columns = [
    'resort',
    'country',
    'continent'
]
%}

WITH flatten_seasons AS (
    SELECT
        resort_id,
        TRIM(S.value::string) AS resort_season
    FROM
        {{ ref("bronze_resorts") }},
        LATERAL FLATTEN(input=> SPLIT(season, ',')) S
)

SELECT 
    r.resort_id,
    {% for string_column in string_columns %}
        {{ cleaner(string_column) }} AS {{ string_column }} {% if not loop.last %}, {% endif %}
    {% endfor %},
    longitude,
    latitude,
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
    highest_point AS highest_point_m,
    lowest_point AS lowest_point_m,
    beginner_slopes AS beginner_slopes_km,
    intermediate_slopes AS intermediate_slopes_km,
    difficult_slopes AS difficult_slopes_km,
    longest_run AS longest_run_km,
    snow_cannons,
    surface_lifts,
    chair_lifts,
    gondola_lifts,
    lift_capacity,
    child_friendly AS is_child_friendly,
    snowparks AS has_snowparks,
    nightskiing AS has_nightskiing,
    summer_skiing AS has_summer_skiing
FROM 
    {{ ref('bronze_resorts')}} AS r
LEFT JOIN 
    flatten_seasons AS s
ON
    r.resort_id = s.resort_id