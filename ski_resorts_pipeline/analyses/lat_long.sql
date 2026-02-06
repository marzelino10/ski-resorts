SELECT
    COUNT(*)
FROM
    {{ ref("bronze_resorts") }}
WHERE latitude IN (
    SELECT latitude
    FROM {{ ref("bronze_snow")}}
);

SELECT
    COUNT(*)
FROM
    {{ ref("bronze_resorts") }}
WHERE longitude IN (
    SELECT longitude
    FROM {{ ref("bronze_snow")}}
)