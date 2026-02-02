{% macro cleaner(col)%}
    TRIM(
        REGEXP_REPLACE({{ col }}, '[\?�]', '') 
        )
{% endmacro %}