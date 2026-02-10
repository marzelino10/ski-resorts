
  create or replace   view ski_db.gold.gold_beginner_expert_resort
  
  
  
  
  as (
    WITH base AS ( 
    SELECT 
        t.resort_id,
        lowest_point_m,
        highest_point_m,
        beginner_slopes_km,
        intermediate_slopes_km,
        difficult_slopes_km,
        TO_NUMBER(is_child_friendly) AS is_child_friendly,
    FROM
        ski_db.silver.silver_terrains AS t
    JOIN
        ski_db.silver.silver_slopes AS s
        ON 
            t.resort_id = s.resort_id
    JOIN 
        ski_db.silver.silver_features AS f
        ON
            t.resort_id = f.resort_id
),
metrics AS (
    SELECT
        *,
        highest_point_m - lowest_point_m AS vertical_drop_m,
        ROUND(beginner_slopes_km / (beginner_slopes_km + intermediate_slopes_km + difficult_slopes_km), 2) AS beginner_slopes_ratio,
        ROUND(intermediate_slopes_km / (beginner_slopes_km + intermediate_slopes_km + difficult_slopes_km), 2) AS intermediate_slopes_ratio,
        ROUND(difficult_slopes_km / (beginner_slopes_km + intermediate_slopes_km + difficult_slopes_km), 2) AS difficult_slopes_ratio
    FROM
        base
),
binary_metrics AS (
    SELECT
        *,
        CASE
            WHEN vertical_drop_m <= 600 THEN 1
            ELSE 0
            END AS low_vertical_drop,
        CASE 
            WHEN vertical_drop_m >= 1000 THEN 1
            ELSE 0
            END AS high_vertical_drop,
        CASE 
            WHEN highest_point_m >= 3000 THEN 1
            ELSE 0
            END AS high_peak
    FROM
        metrics
),
scoring AS (
    SELECT
        *,
        (
            0.6 * beginner_slopes_ratio +
            0.2 * is_child_friendly +
            0.2 * low_vertical_drop
        ) AS beginner_score,
        (
            0.6 * difficult_slopes_ratio + 
            0.3 * high_vertical_drop + 
            0.1 * high_peak
        ) AS expert_score
    FROM
        binary_metrics
),
final AS (
    SELECT
        resort_id,
        beginner_score,
        expert_score,
        CASE 
            WHEN beginner_score >= 0.6 THEN 'Beginner'
            WHEN expert_score >= 0.6 THEN 'Expert'
            ELSE 'Intermediate'
            END AS resort_overall_difficulty
    FROM
        scoring
)

SELECT * FROM final
  );

