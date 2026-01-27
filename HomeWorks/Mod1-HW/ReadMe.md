# Module 1 Homework: Docker & SQL

## Question 1. Understanding Docker images

Run docker with the `python:3.13` image. Use an entrypoint `bash` to interact with the container.

```docker
docker run -it --entrypoint bash python:3.13
```

What's the version of `pip` in the image?
- 25.3

## Question 2. Understanding Docker networking and docker-compose

- postgres:5432
- db:5432

## Prepare the Data

Download the green taxi trips data for November 2025:

```bash
wget https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2025-11.parquet
```

You will also need the dataset with zones:

```bash
wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv
```

## Question 3. Counting short trips

For the trips in November 2025 (lpep_pickup_datetime between '2025-11-01' and '2025-12-01', exclusive of the upper bound), how many trips had a `trip_distance` of less than or equal to 1 mile?

```SQL
select count(*) from trip 
where lpep_pickup_datetime between '2025-11-01' and '2025-12-01' and trip_distance <= 1
;
```
- 8,007



## Question 4. Longest trip for each day

Which was the pick up day with the longest trip distance? Only consider trips with `trip_distance` less than 100 miles (to exclude data errors).

Use the pick up time for your calculations.

```SQL
select max(trip_distance) as max_distance, trip.lpep_pickup_datetime from trip
where trip.trip_distance < 100 
group by trip.lpep_pickup_datetime 
order by max_distance desc

;
```
- 2025-11-14



## Question 5. Biggest pickup zone

Which was the pickup zone with the largest `total_amount` (sum of all trips) on November 18th, 2025?

```SQL
select sum(t.total_amount) as TA, z."Zone" from trip t join zone z
on t."PULocationID" = z."LocationID"
where date(t.lpep_pickup_datetime) = '2025-11-18'
group by z."Zone"
order by TA desc;
```

- East Harlem North



## Question 6. Largest tip

For the passengers picked up in the zone named "East Harlem North" in November 2025, which was the drop off zone that had the largest tip?

Note: it's `tip` , not `trip`. We need the name of the zone, not the ID.
```SQL
select z."Zone" from zone z join trip t
on t."DOLocationID" = z."LocationID"
where t.tip_amount = (select max(tip_amount) from zone z join trip t
on t."PULocationID" = z."LocationID"
WHERE z."Zone" = 'East Harlem North'
  AND t.lpep_pickup_datetime >= '2025-11-01'
  AND t.lpep_pickup_datetime <  '2025-12-01')

```

- Yorkville West



## Terraform

In this section homework we'll prepare the environment by creating resources in GCP with Terraform.

In your VM on GCP/Laptop/GitHub Codespace install Terraform.
Copy the files from the course repo
[here](../../../01-docker-terraform/terraform/terraform) to your VM/Laptop/GitHub Codespace.

Modify the files as necessary to create a GCP Bucket and Big Query Dataset.


## Question 7. Terraform Workflow

Which of the following sequences, respectively, describes the workflow for:
1. Downloading the provider plugins and setting up backend,
2. Generating proposed changes and auto-executing the plan
3. Remove all resources managed by terraform`

Answers:
- terraform init, terraform apply -auto-approve, terraform destroy




