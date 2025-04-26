# Redfin Real Estate Data Analytics ETL Pipeline

This project showcases a full-fledged ETL (Extract, Transform, Load) pipeline for processing real estate data from Redfin. The pipeline leverages Python, AWS, Snowflake, and Power BI to extract, transform, load, and visualize real estate data, providing insights into market trends.

## Project Overview

### 1. Data Extraction
The pipeline begins by connecting to the Redfin data source and extracting real estate data using Python.

### 2. Data Transformation
The extracted data is then transformed using pandas. This step involves cleaning the data, handling missing values, and formatting it to suit analytical needs. Both raw and transformed data are stored in an Amazon S3 bucket for further processing.

### 3. Data Loading
Upon arrival in the S3 bucket, an AWS Snowpipe is triggered. Snowpipe automatically runs a COPY command to load the transformed data into a Snowflake data warehouse table, making it available for querying and analysis.

### 4. Data Visualization
Finally, Power BI is connected to the Snowflake data warehouse. This enables the creation of visualizations that provide actionable insights based on the processed real estate data.

## Key Technologies

- **Python**: For scripting and data processing.
- **pandas**: To transform and clean the data.
- **Amazon S3**: For storing raw and transformed data.
- **Snowpipe**: To automate data loading into Snowflake.
- **Snowflake**: As the data warehouse for storing and querying the data.
- **Power BI**: For data visualization.
