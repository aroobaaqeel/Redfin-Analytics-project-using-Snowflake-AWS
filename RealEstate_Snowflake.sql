Create database redfin_database;
use redfin_database;
create schema redfin_schema;

CREATE OR REPLACE TABLE redfin_database.redfin_schema.redfin_table (
period_begin DATE,
period_end DATE,
period_duration INT,
region_type STRING,
region_type_id INT,
table_id INT,
is_seasonally_adjusted STRING,
city STRING,
state STRING,
state_code STRING,
property_type STRING,
property_type_id INT,
median_sale_price FLOAT,
median_list_price FLOAT,
median_ppsf FLOAT,
median_list_ppsf FLOAT,
homes_sold FLOAT,
inventory FLOAT,
months_of_supply FLOAT,
median_dom FLOAT,
avg_sale_to_list FLOAT,
sold_above_list FLOAT,
parent_metro_region_metro_code STRING,
last_updated DATETIME,
period_begin_in_years STRING,
period_end_in_years STRING,
period_begin_in_months STRING,
period_end_in_months STRING
);
SELECT *
FROM redfin_database.redfin_schema.redfin_table LIMIT 10;

truncate table redfin_database.redfin_schema.redfin_table; 

SELECT COUNT(*) FROM redfin_database.redfin_schema.redfin_table;

// Create file format object
CREATE SCHEMA file_format_schema;
CREATE OR REPLACE file format redfin_database.file_format_schema.format_csv
    type = 'CSV'
    field_delimiter = ','
    RECORD_DELIMITER = '\n'
    skip_header = 1;
    -- error_on_column_count_mismatch = FALSE;

// Create staging schema
CREATE SCHEMA external_stage_schema;
// Create staging
-- DROP STAGE redfin_database.external_stage_schema.redfin_ext_stage_yml;
CREATE OR REPLACE STAGE redfin_database.external_stage_schema.redfin_ext_stage_yml 
    url="s3://redfin-transform-projectetl/"
    credentials=(aws_key_id='xxxxx'
    aws_secret_key='xxxxxx')
    FILE_FORMAT = redfin_database.file_format_schema.format_csv;

list @redfin_database.external_stage_schema.redfin_ext_stage_yml;

CREATE OR REPLACE SCHEMA redfin_database.snowpipe_schema;

// Create Pipe
CREATE OR REPLACE PIPE redfin_database.snowpipe_schema.redfin_snowpipe
auto_ingest = TRUE
AS 
COPY INTO redfin_database.redfin_schema.redfin_table
FROM @redfin_database.external_stage_schema.redfin_ext_stage_yml;

DESC PIPE redfin_database.snowpipe_schema.redfin_snowpipe;
