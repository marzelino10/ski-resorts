SELECT
    cr.resort_id,
    resort,
    country,
    continent,
    latitude,
    longitude,
    euro_price,
    lowest_point_m,
    highest_point_m,
    is_child_friendly,
    has_snowparks,
    has_nightskiing,
    has_summer_skiing,
FROM
    ski_db.silver.silver_resorts AS cr
LEFT JOIN
    ski_db.silver.silver_locations AS cl
    ON 
        cr.location_id = cl.location_id
LEFT JOIN
    ski_db.silver.silver_countries AS cc
    ON 
        cl.country_id = cc.country_id
LEFT JOIN
    ski_db.silver.silver_terrains AS ct
    ON
        cr.terrain_id = ct.terrain_id
LEFT JOIN
    ski_db.silver.silver_slopes AS cs
    ON
        cr.slope_id = cs.slope_id
LEFT JOIN
    ski_db.silver.silver_lifts AS cli
    ON
        cr.lift_id = cli.lift_id
LEFT JOIN
    ski_db.silver.silver_features AS cf
    ON
        cr.feature_id = cf.feature_id