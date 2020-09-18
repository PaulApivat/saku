
##select unique funnel_id (3)
## 9336319, 9335667, 9395015

SELECT DISTINCT(funnel_id) FROM `jobsbot-276604.jobsbot_mixpanel.mixpanel_funnels` LIMIT 10

## select unique dates (107)

SELECT DISTINCT(date) FROM `jobsbot-276604.jobsbot_mixpanel.mixpanel_funnels` LIMIT 1000

## select unique starting amount (18)

SELECT DISTINCT(starting_amount) FROM `jobsbot-276604.jobsbot_mixpanel.mixpanel_funnels` LIMIT 1000

## select starting_amount, _sdc_received_at Order By starting_amount DESC
## What does starting amount refer to?
## NOTE: _sdc_ is a Stitch integration schema

SELECT DISTINCT(starting_amount), _sdc_received_at 
FROM `jobsbot-276604.jobsbot_mixpanel.mixpanel_funnels` 
ORDER BY starting_amount DESC
LIMIT 1000

## NOTE: Unable to make sense of Mixpanel Funnel Dataset

## Explore with Data Studio ##

steps.value.step_label      Record Count▼
1. Session Start            321
2. get job details          214
3. job lising               214
4. share job                107
5. Session End              107
6. go to smartjob           107
7. contact employer         107


## Assumption: avg_time in milliseconds??? per each step_label

steps.value.step_label      steps.value.avg_time▼
1. contact employer         6,034,441
2. job lising               875,397
3. get job details          329,225
4. share job                261,371
5. Session End              8,752
6. go to smartjob           30
7. Session Start

