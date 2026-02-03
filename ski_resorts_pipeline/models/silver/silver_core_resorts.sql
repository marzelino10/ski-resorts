SELECT 
    r.resort_id,
    resort,
    location_id,
    euro_price,
    season_start_month,
    season_end_month,
    terrain_id,
    slope_id,
    lift_id,
    feature_id
FROM 
    {{ ref('silver_resorts')}} AS r
LEFT JOIN
    {{ ref("silver_core_locations") }} AS cl
    ON 
        r.latitude = cl.latitude
    AND r.longitude = cl.longitude
LEFT JOIN
    {{ ref("silver_core_terrain") }} AS ct
    ON
        r.resort_id = ct.resort_id
LEFT JOIN
    {{ ref("silver_core_slopes") }} AS cs
    ON
        r.resort_id = cs.slope_id
LEFT JOIN
    {{ ref("silver_core_lifts") }} AS cli
    ON
        r.resort_id = cli.resort_id
LEFT JOIN
    {{ ref("silver_core_features") }} AS cf
    ON
        r.resort_id = cf.resort_id