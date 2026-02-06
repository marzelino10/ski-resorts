{% set string_columns = [
    'country',
    'continent'
]
%}

WITH distinct_country AS (
    SELECT
        DISTINCT
        {% for string_column in string_columns %}
        {{ cleaner(string_column) }} AS {{ string_column }} {% if not loop.last %}, {% endif %}
        {% endfor %}
    FROM 
        {{ ref("bronze_resorts")}}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY country, continent) AS country_id,
    country, 
    continent
FROM
    distinct_country