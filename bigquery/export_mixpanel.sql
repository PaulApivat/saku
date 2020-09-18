## mixpanel_export ##

## Distinct job_id (97)

SELECT DISTINCT(job_id) FROM `jobsbot-276604.jobsbot_mixpanel.mixpanel_export` LIMIT 1000

## Distinct job_id, event

SELECT DISTINCT(job_id), event FROM `jobsbot-276604.jobsbot_mixpanel.mixpanel_export` LIMIT 1000

## How does job_id differ from distinct_id?
SELECT DISTINCT(distinct_id) FROM `jobsbot-276604.jobsbot_mixpanel.mixpanel_export` LIMIT 1000

## ------ Count Distinct Events ------ ##
## NOTE: to see count of event, must group by event

SELECT DISTINCT(event), COUNT(event)  
FROM `jobsbot-276604.jobsbot_mixpanel.mixpanel_export` 
GROUP BY event
LIMIT 1000

Row	    event	        f0_	
1	job lising          461
2	get job details     105
3	go to smartjob      115
4	share job           12
5	contact employer    6

