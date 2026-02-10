USE ROLE accountadmin;
CREATE WAREHOUSE IF NOT EXISTS ski_wh WITH WAREHOUSE_SIZE = 'x-small';
CREATE DATABASE IF NOT EXISTS ski_db;

USE WAREHOUSE ski_wh;
USE DATABASE ski_db;

CREATE SCHEMA IF NOT EXISTS staging;

USE SCHEMA staging;

CREATE OR REPLACE TABLE ski_resorts (
    resort_id NUMBER(10,0),
    resort STRING,
    latitude FLOAT,
    longitude FLOAT,
    country STRING,
    continent STRING,
    price NUMBER(10,0),
    season STRING,
    highest_point NUMBER(10,0),
    lowest_point NUMBER(10,0),
    beginner_slopes NUMBER(10,0),
    intermediate_slopes NUMBER(10,0),
    difficult_slopes NUMBER(10,0),
    total_slopes NUMBER(10,0),
    longest_run NUMBER(10,0),
    snow_cannons NUMBER(10,0),
    surface_lifts NUMBER(10,0),
    chair_lifts NUMBER(10,0),
    gondola_lifts NUMBER(10,0),
    total_lifts NUMBER(10,0),
    lift_capacity NUMBER(10,0),
    child_friendly BOOLEAN,
    snowparks BOOLEAN,
    nightskiing BOOLEAN,
    summer_skiing BOOLEAN
)
;


CREATE OR REPLACE TABLE ski_snow (
    month DATE,
    latitude FLOAT,
    longitude FLOAT,
    snow FLOAT
);


CREATE OR REPLACE FILE FORMAT csv_format
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    REPLACE_INVALID_CHARACTERS = TRUE;


CREATE OR REPLACE STAGE snowstage
    FILE_FORMAT = csv_format
    URL = 's3://snowflake-bucket-mm/ski-resorts/';


COPY INTO ski_resorts
FROM @snowstage
FILES = ('resorts.csv')
CREDENTIALS = (aws_key_id = '*****', aws_secret_key = '*****');

COPY INTO ski_snow
FROM @snowstage
FILES = ('snow.csv')
CREDENTIALS = (aws_key_id = '*****', aws_secret_key = '*****');