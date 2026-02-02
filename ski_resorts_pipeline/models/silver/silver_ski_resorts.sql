{% set string_columns = [
    'resort',
    'country',
    'continent',
    'season'
]
%}

SELECT 
    resort_id,
    {% for string_column in string_columns %}
        {{ cleaner(string_column) }} AS {{ string_column }} {% if not loop.last %}, {% endif %}
    {% endfor %},
    ST_MAKEPOINT(longitude, latitude) as resort_geopoint,
    price,
    highest_point,
    lowest_point,
    beginner_slopes,
    intermediate_slopes,
    difficult_slopes,
    total_slopes,
    longest_run,
    snow_cannons,
    surface_lifts,
    chair_lifts,
    gondola_lifts,
    total_lifts,
    lift_capacity,
    child_friendly,
    snowparks,
    nightskiing,
    summer_skiing
FROM 
    {{ ref('bronze_ski_resorts')}}