# ⛷️ Ski Resorts dbt Project

This directory contains the **dbt transformation layer** for the Global Ski Resorts data pipeline.

dbt is used to transform raw Snowflake data into **clean, normalized silver models** and **analytics-ready gold models**, following the **Medallion Architecture** pattern.

The focus of this dbt project is:
- Data quality and consistency
- Clear separation of concerns (bronze / silver / gold)
- Business-oriented analytical modeling
  
---

## 📘 dbt Documentation

The full dbt documentation (models, lineage, tests, and descriptions) is hosted here:

👉 **Live dbt Docs:**  
[![dbt Docs](https://img.shields.io/badge/dbt_docs-005FF9?style=for-the-badge&logo=googlechrome&logoColor=white)](https://marzelino10.github.io/ski-resorts/dbt)

---

## 📂 dbt Repository Structure
```
ski_resorts_pipeline/

├── analyses/                                   # Ad-hoc analytical SQL for validation and exploration
│   ├── lat_long.sql                            # Validate latitude & longitude consistency across datasets
│   ├── snow_month.sql                          # Inspect temporal coverage of snow data
│   ├── total_slopes_lifts.sql                  # Validate slope and lift aggregations
│
├── macros/                                     # Reusable dbt macros                            
│   ├── cleaner.sql                             # String cleaning using regex transformations and trimming
│   ├── generate_schema_name.sql                # Custom schema naming by model layer
│
├── models/                                     
│   ├── sources/                                # External Snowflake source definitions
│   │   ├── sources.yml                         
│   │
│   ├── bronze/                                 # Raw ingestion layer
│   │   ├── bronze_resorts.sql                  
│   │   ├── bronze_snow.sql                     
│   │ 
│   ├── silver/                                 # Cleaned and normalized models
│   │   ├── silver_countries.sql                # Country-level dimension
│   │   ├── silver_locations.sql                # Resort locations
│   │   ├── silver_features.sql                 # Resort features and services
│   │   ├── silver_slopes.sql                   # Slope characteristics
│   │   ├── silver_lifts.sql                    # Lift types and counts
│   │   ├── silver_terrains.sql                 # Terrain difficulty breakdown
│   │   ├── silver_resorts.sql                  # Core resort entity
│   │   ├── silver_snow.sql                     # Snow coverage by grid and month
│   │ 
│   ├── gold/                                   # Analytics-ready models
│   │   ├── gold_resort_overview.sql            # High-level resort summary
│   │   ├── gold_resort_season.sql              # Resort opening seasons
│   │   ├── gold_resort_snow_coverage.sql       # Monthly snow coverage per resort (spatial join)
│   │   ├── gold_beginner_expert_resort.sql     # Resort difficulty classification
│
├── seeds/                                      # Reserved for static reference data (unused)
│
├── snapshots/                                  # Reserved for historical tracking (unused)
│
├── tests/                                      # Custom data quality tests
│   ├── bronze_resorts_lat_long.sql             # Resort latitude/longitude range validation
│   ├── bronze_snow_lat_long.sql                # Snow grid latitude/longitude range validation
│   ├── generic_tests.yml                       # Not-null, uniqueness, and accepted values tests
│
├── .gitignore                                  
├── dbt_project.yml                             # Main configuration file for the whole dbt project
├── profiles.yml                                # Credentials for external connection to Snowflake
└── README.md                                  
```

---

## 🧠 Key Business Logic & Modeling Decisions

This section describes the core transformations and analytical logic implemented in the **gold layer** of the dbt project.

---

### ❄️ Snow Coverage Modeling (Spatial Join)

Snow coverage data and resort location data use **different spatial representations** and therefore cannot be joined using standard equality joins.

- **`silver_resorts`**
  - Represents a single geographic point for each resort location

- **`silver_snow`**
  - Represents the center point of a **0.25° × 0.25° snow coverage grid**

To accurately associate snow coverage with each resort:

1. Latitude and longitude fields in both tables are converted to Snowflake’s `GEOGRAPHY` data type
2. A spatial join is performed using `ST_DISTANCE`
3. Snow grid points within a **30 km radius** of each resort are included

The 30 km threshold is chosen to slightly exceed the snow grid diagonal (~27 km), ensuring complete coverage while minimizing spatial noise.

---

### ⭐ Resort Difficulty Classification

Each resort is evaluated using **two independent scores**:
- **Beginner Score**
- **Expert Score**

This approach reflects the fact that a resort may be suitable for multiple skill levels depending on its terrain, amenities, and elevation characteristics.

#### A. Beginner-Friendly Criteria

A resort is considered beginner-friendly based on the following factors:

1. A higher proportion of beginner slopes
2. Availability of child-friendly amenities (used as a proxy for beginner accessibility)
3. A relatively low vertical drop (≤ 600 meters)

**Beginner Score Calculation**

```text
Beginner Score =
  0.6 × Beginner slope ratio +
  0.2 × Child-friendliness +
  0.2 × Low vertical drop
```

#### B. Expert-Friendly Criteria

A resort is considered expert-friendly when it offers terrain and elevation characteristics that cater to advanced and professional skiers. The classification is based on the following factors:

1. A high proportion of difficult slopes relative to total available slopes
2. A significant vertical drop, indicating challenging elevation changes (> 1,000 meters)
3. A high peak elevation, reflecting advanced and demanding terrain (> 3,000 meters)

**Expert Score Calculation**

```text
Expert Score =
  0.6 × Difficult slope ratio +
  0.3 × High vertical drop +
  0.1 × High peak elevation
```

#### C. Final Resort Classification

Each resort is categorized based on the calculated **Beginner Score** and **Expert Score**:

-  **Beginner Resort**
Beginner Score ≥ 0.6

- **Expert Resort**
Expert Score ≥ 0.6

- **Intermediate Resort**
Resorts that do not meet either threshold

This dual-scoring approach allows a resort to qualify for multiple skill levels and avoids rigid, single-metric classifications.

#### D. Notes & Assumptions

- Scoring weights and thresholds are derived from the attributes available in the dataset
- Difficulty classification is designed to be extensible as additional resort features become available
- Thresholds are intentionally conservative to reduce misclassification