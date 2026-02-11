# 🏔️ Global Ski Resorts Data Pipeline

## Project Overview

This project demonstrates a **production-style, end-to-end data engineering pipeline** built to ingest, transform, and model **global ski resort and snow coverage data** for analytics and decision-making using **Snowflake** and **dbt**.

The pipeline is designed to answer real-world analytical questions such as:

- Which **countries** have the most ski resorts?
- How do **ski seasons vary by geography**, and how does this align with **snow coverage**?
- Which resorts offer the **highest peaks** and **largest elevation drops**?
- Which resorts are best suited for **beginners** versus **expert skiers**?

The primary focus of this project is **data architecture, transformation quality, and analytical modeling**, rather than surface-level analysis.

---

## 📘 Project Documentation

Full project documentation is available here:

👉 **Live Documentation:**  
[![Repo Docs](https://img.shields.io/badge/repo_docs-005FF9?style=for-the-badge&logo=googlechrome&logoColor=white)](https://marzelino10.github.io/ski-resorts/)

---

## 🏗️ Data Architecture

Source data is obtained from the  
**[Maven Analytics Data Playground – Ski Resorts dataset](https://mavenanalytics.io/data-playground/ski-resorts)**  
and stored in **Amazon S3** as the system of record.

The pipeline follows the **Medallion Architecture (Bronze → Silver → Gold)** pattern and is implemented using **Snowflake** and **dbt**.


![Data Architecture](docs/architecture/data_architecture.png)


### 🥉 Bronze Layer

- Raw datasets are ingested from **Amazon S3** into **Snowflake**
- Minimal transformations are applied
- Source data is preserved for traceability and reprocessing
- Secure access is handled via **AWS IAM**

### 🥈 Silver Layer

- Data is cleaned, standardized, and validated using **dbt**
- Schema normalization and data quality checks are applied
- Inconsistent season formats and geographic fields are standardized
- Data is prepared for analytical joins and modeling

### 🥇 Gold Layer

- **Domain-specific transformations** and scoring logic
- Optimized for BI tools and ad-hoc SQL analysis
- Designed to directly answer stakeholder questions

---

## 💻 Tech Stack

| Layer | Tool |
|---|---|
| Object Storage | AWS S3 |
| Authentication | AWS IAM |
| Data Warehouse | Snowflake |
| Transformations | dbt |
| Version Control | Git & GitHub |

---

## 📂 Repository Structure
```
ski-resorts/

├── datasets/                         # Raw source datasets 
│   ├── resorts.csv                   # Global ski resorts data in 2020
│   ├── snow.csv                      # Monthly snow coverage data in 2020
│
├── docs/                             # Documentation and visuals                       
│   ├── architecture                  
│   │   ├── data_dictionary.csv       # Field-level metadata
│   │   ├── data_architecture.png     # Pipeline architecture diagram
│   │   ├── dbt_dag.png               # dbt lineage graph
│   │   ├── dbt_build.png             # successful dbt build screenshot
│   │   ├── s3_bucket.png             # S3 bucket screenshot
│   │   ├── snowflake_ingestion.png   # Snowflake screenshot
│   │   
│   ├── dbt/                          # dbt docs assets             
│   │              
│   ├── index.html                    # Landing page        
│
├── ski_resorts_pipeline/             # dbt project directory (More on this in the directory itself)
│
├── snowflake/                        # SQL script in Snowflake
│   ├── snowflake_init.sql            # Script for ingesting data from AWS S3 to Snowflake
│
├── .gitignore                       
├── .python-version                 
├── README.md                        
└── pyproject.toml                    # Dependencies and requirements for the project
```

---

## ⚠️ Limitations

- **Static source data**  
  The dataset represents a fixed snapshot in time and does not capture real-time or historical changes.

- **Manual ingestion process**  
  Data ingestion is performed as a one-time batch load and is not yet automated.

- **Simplified scoring logic**  
  Beginner and expert classifications are based on a limited set of available features and predefined thresholds.

- **Snow coverage approximation**  
  Snow coverage is inferred using grid-based spatial joins, which may not perfectly reflect on-the-ground conditions.

- **Limited validation against external sources**  
  Results are not cross-validated with external datasets or domain-specific benchmarks.


---

## 🚀 Future Improvements

This project focuses on building a solid analytical foundation. Potential future enhancements include:

- **Automated ingestion**  
  Replace one-time batch loads with scheduled data ingestion and orchestration.

- **Incremental models & performance tuning**  
  Use dbt incremental models and Snowflake optimization techniques to improve runtime efficiency.

- **Expanded data quality checks**  
  Add freshness, anomaly, and business-logic validation tests.

- **Dimensional modeling for BI**  
  Introduce clearer fact and dimension tables optimized for dashboarding.

- **Analytics & visualization**  
  Connect gold models to a BI tool for interactive reporting and insights.

---

## 🌟 About Me

Hi, I’m **Marzelino Malintoi**.

I’m a **data analyst transitioning into data engineering**, with a strong interest in building **scalable, production-style data pipelines** and **well-modeled analytics layers**.

My focus areas include:
- **SQL-first** analytics engineering
- **Cloud data platforms** (Snowflake, AWS)
- **dbt** transformations, testing, and documentation
- **Data architecture** patterns (Medallion, dimensional modeling)

Feel free to connect with me or explore my projects below.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/marzelino/)
[![X](https://img.shields.io/badge/Twitter-000000.svg?style=for-the-badge&logo=x)](https://x.com/zelo_project)
[![Portfolio](https://img.shields.io/badge/Portfolio-005FF9?style=for-the-badge&logo=googlechrome&logoColor=white)](https://www.datascienceportfol.io/marzelinomalintoi)