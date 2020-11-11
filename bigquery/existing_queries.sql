# source: internalmongo > crawl_smartjob
# group by jobfieldname
# data studio: temp1_jobfieldname

SELECT jobannounce.jobfieldname, COUNT(jobannounce.jobfieldname)  
FROM `jobsbot-276604.internalmongo.crawl_smartjob` 
GROUP BY jobannounce.jobfieldname 
LIMIT 40


# source: internalmongo > crawl_smartjob
# group by jobdescription order by jobdescription
# data studio: temp2_jobdescription
# filter out null value

SELECT jobannounce.jobdescription, COUNT(jobannounce.jobdescription)
FROM `jobsbot-276604.internalmongo.crawl_smartjob`
WHERE (jobannounce.jobdescription != '-') 
GROUP BY jobannounce.jobdescription
ORDER BY COUNT(jobannounce.jobdescription) DESC
LIMIT 300

# source: jobsbot > smartjob
# data studio: Existing Queries BQ
# filter out null value

SELECT JobAnnounce_Qualification_DegreeName, COUNT(JobAnnounce_Qualification_DegreeName) AS num
FROM `jobsbot-276604.jobsbot.smartjob` 
WHERE (JobAnnounce_Qualification_DegreeName IS NOT NULL)
GROUP BY JobAnnounce_Qualification_DegreeName
ORDER BY num DESC
LIMIT 10

# source: jobsbot > qualification_curriculumname
# data studio: Existing Queries BQ
# filter out null value

SELECT JobAnnounce_Qualification_CurriculumName, COUNT(JobAnnounce_Qualification_CurriculumName) AS num
FROM `jobsbot-276604.jobsbot.smartjob` 
WHERE (JobAnnounce_Qualification_CurriculumName IS NOT NULL)
GROUP BY JobAnnounce_Qualification_CurriculumName
ORDER BY num DESC
LIMIT 150

# source: sakudemo > export 
# table name: event_count
# data studio: Existing Queries BQ

SELECT event, COUNT(event) as num 
FROM `jobsbot-276604.sakudemo.export` 
GROUP BY event
ORDER BY num DESC
LIMIT 10


# source: sakudemo > export
# table name: id_count
# data studio: Existing Queries BQ

SELECT distinct_id, COUNT(distinct_id) AS num
FROM `jobsbot-276604.sakudemo.export` 
GROUP BY distinct_id
ORDER BY num DESC
LIMIT 200

# source: jobsbot_mixpanel > mixpanel_export
# table name: event_count
# data studio: Existing Queries BQ


SELECT event, COUNT(event) as num
FROM `jobsbot-276604.jobsbot_mixpanel.mixpanel_export` 
GROUP BY event
ORDER BY num DESC
LIMIT 1000
