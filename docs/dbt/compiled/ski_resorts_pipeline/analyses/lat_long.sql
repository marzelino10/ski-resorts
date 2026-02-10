SELECT
    COUNT(*)
FROM
    ski_db.bronze.bronze_resorts
WHERE latitude IN (
    SELECT latitude
    FROM ski_db.bronze.bronze_snow
);

SELECT
    COUNT(*)
FROM
    ski_db.bronze.bronze_resorts
WHERE longitude IN (
    SELECT longitude
    FROM ski_db.bronze.bronze_snow
)