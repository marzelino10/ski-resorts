SELECT
    MIN(month),
    MAX(month),
    COUNT(DISTINCT(month))
FROM
    {{ ref("bronze_snow") }}