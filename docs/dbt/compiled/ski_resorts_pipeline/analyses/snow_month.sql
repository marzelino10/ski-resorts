SELECT
    MIN(month),
    MAX(month),
    COUNT(DISTINCT(month))
FROM
    ski_db.bronze.bronze_snow