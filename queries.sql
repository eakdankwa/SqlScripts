/* 
Query 1: 
This query creates the CTE for the columns of interest. 
*/

WITH all_table AS (
  SELECT   
    down.platform,
    down.download_ts,
    down.app_download_key,
    sign.user_id AS signup_users,
    COALESCE(sign.age_range, 'Unknown') AS age_range,
    req.user_id AS request_users,
    req.ride_id AS requested_ride,
		acc.accepted_users AS ride_accepted_users,
  	acc.accepted_ride AS ride_accepted,
    com.completed_users AS ride_complete_users,
  	com.completed_ride AS ride_completed,
  	pay.paid_users AS ride_paid_users,
  	pay.paid_ride AS ride_paid,
    rev.user_id AS review_users,
    rev.review_id AS ride_reviewed
  FROM app_downloads down
  FULL OUTER JOIN signups sign ON down.app_download_key = sign.session_id
  LEFT JOIN ride_requests req ON req.user_id = sign.user_id
  LEFT JOIN (
    SELECT ride_id AS accepted_ride, user_id AS accepted_users
    FROM ride_requests
    WHERE accept_ts IS NOT NULL
    ) acc ON acc.accepted_ride= req.ride_id
  LEFT JOIN (
    SELECT ride_id AS completed_ride, user_id AS completed_users
    FROM ride_requests
    WHERE dropoff_ts IS NOT NULL
    ) com ON com.completed_ride = req.ride_id
  LEFT JOIN (
    SELECT tr.ride_id AS paid_ride, rid.user_id AS paid_users
    FROM ride_requests rid
    LEFT JOIN transactions tr USING(ride_id)
    WHERE tr.charge_status = 'Approved'
    ) pay ON pay.paid_ride = req.ride_id
  LEFT JOIN reviews rev ON rev.ride_id = req.ride_id
),


/* 
Query 2: 
This query creates the CTE that combines the funnel columns and attribute columns. 
*/

tableau_table AS ( 
  SELECT 
    1 AS funnel_step,
    'downloads' AS funnel_name,
    COUNT(DISTINCT app_download_key) AS users,
  	0 AS rides,
    age_range,
    platform,
    date(download_ts) AS download_date
  FROM all_table
  GROUP BY 4, 5, 6,7
  UNION
  SELECT 
    2 AS funnel_step,
    'signups' AS funnel_name,
    COUNT(DISTINCT signup_users) AS users,
  	0 AS rides,
    age_range,
    platform,
    date(download_ts) AS download_date
  FROM all_table
  GROUP BY 4, 5, 6,7
  UNION
  SELECT 
    3 AS funnel_step,
    'ride_requested' AS funnel_name,
    COUNT(DISTINCT request_users) AS users,
  	COUNT(requested_ride) AS rides,
    age_range,
    platform,
    date(download_ts) AS download_date
  FROM all_table
  GROUP BY 5, 6, 7
  UNION
  SELECT 
    4 AS funnel_step,
    'rides_accepted' AS funnel_name,
    COUNT(DISTINCT ride_accepted_users) AS users,
  	COUNT(ride_accepted) AS rides,
    age_range,
    platform,
    date(download_ts) AS download_date
  FROM all_table
  GROUP BY 5, 6,7
  UNION
  SELECT 
    5 AS funnel_step,
    'rides_completed' AS funnel_name,
    COUNT(DISTINCT ride_complete_users) AS users,
  	COUNT(ride_completed) AS rides,
    age_range,
    platform,
    date(download_ts) AS download_date
  FROM all_table
  GROUP BY 5, 6, 7
  UNION
  SELECT 
    6 AS funnel_step,
    'rides_paid' AS funnel_name,
    COUNT(DISTINCT ride_paid_users) AS users,
  	COUNT(ride_paid) AS rides,
    age_range,
    platform,
    date(download_ts) AS download_date
  FROM all_table
  GROUP BY 5, 6, 7
  UNION
  SELECT 
    7 AS funnel_step,
    'rides_reviewed' AS funnel_name,
    COUNT(DISTINCT review_users) AS users,
  	COUNT(ride_reviewed) AS rides,
    age_range,
    platform,
    date(download_ts) AS download_date
  FROM all_table
  GROUP BY 5, 6, 7
)

/* 
Query 3: 
This query returns all the columns of interest for the customer funnel analysis
*/

SELECT * FROM tableau_table
;



/*  
Query 4: 
This particular query, the rides request per request timestamp and will be used to create viz. in tableau to answer "Surge pricing" business question.
*/

SELECT ride_id,
request_ts
FROM ride_requests
;