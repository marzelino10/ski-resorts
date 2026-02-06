WITH a AS ( 
    SELECT
        resort_id,
        beginner_slopes_km + intermediate_slopes_km + difficult_slopes_km AS calc_total_slopes,
        total_slopes,
        surface_lifts + chair_lifts + gondola_lifts AS calc_total_lifts,
        total_lifts
    FROM
        {{ ref("bronze_resorts") }})

SELECT 
    *
FROM a 
WHERE calc_total_lifts != total_lifts OR calc_total_slopes != total_slopes