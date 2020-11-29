# source: BigQuery > jobsbot > prodmongo

# temp_jobs
SELECT position, job_description, created_at 
FROM `jobsbot-276604.prodmongo.jobs` 
LIMIT 10

# temp_profiles
SELECT full_name, age, gender, university_name, created_at 
FROM `jobsbot-276604.prodmongo.profiles` 
LIMIT 10