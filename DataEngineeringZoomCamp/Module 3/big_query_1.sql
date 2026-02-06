CREATE OR REPLACE EXTERNAL TABLE `western-tea-485016-j2.zoomcamp.external_yellow_tripdata1`
OPTIONS (
  format = 'parquet',
  uris = ['gs://samhitha-kestra/yellow_tripdata_2024-*']
);

SELECT * FROM western-tea-485016-j2.zoomcamp.external_yellow_tripdata1 limit 10;


CREATE OR REPLACE TABLE western-tea-485016-j2.zoomcamp.external_yellow_tripdata1_non_partitioned AS
SELECT * FROM western-tea-485016-j2.zoomcamp.external_yellow_tripdata1;

-- Create a partitioned table from external table
CREATE OR REPLACE TABLE western-tea-485016-j2.zoomcamp.external_yellow_tripdata1_partitioned
PARTITION BY
  DATE(tpep_pickup_datetime) AS
SELECT * FROM western-tea-485016-j2.zoomcamp.external_yellow_tripdata1;

-- Impact of partition
-- Scanning 1.6GB of data
SELECT DISTINCT(VendorID)
FROM western-tea-485016-j2.zoomcamp.external_yellow_tripdata1_non_partitioned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-06-30';

-- Scanning ~106 MB of DATA
SELECT DISTINCT(VendorID)
FROM western-tea-485016-j2.zoomcamp.external_yellow_tripdata1_partitioned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-06-30';

-- Let's look into the partitions
SELECT table_name, partition_id, total_rows
FROM `zoomcamp.INFORMATION_SCHEMA.PARTITIONS`
WHERE table_name = 'external_yellow_tripdata1_partitioned'
ORDER BY total_rows DESC;

-- Creating a partition and cluster table
CREATE OR REPLACE TABLE western-tea-485016-j2.zoomcamp.external_yellow_tripdata1_partitioned_clustered
PARTITION BY DATE(tpep_pickup_datetime)
CLUSTER BY VendorID AS
SELECT * FROM western-tea-485016-j2.zoomcamp.external_yellow_tripdata1;

-- Query scans 1.1 GB
SELECT count(*) as trips
FROM western-tea-485016-j2.zoomcamp.external_yellow_tripdata1_partitioned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31'
  AND VendorID=1;

-- Query scans 864.5 MB
SELECT count(*) as trips
FROM western-tea-485016-j2.zoomcamp.external_yellow_tripdata1_partitioned_clustered
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31'
  AND VendorID=1;
