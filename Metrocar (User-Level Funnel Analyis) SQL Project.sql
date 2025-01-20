--USER LEVEL GRANULARITY (DETAILS) Funnel Analysis
 
-- number of app downloads [23,608]
 SELECT COUNT(DISTINCT app_download_key) AS user_downloads
 FROM app_downloads
;

-- number of signups [17,623]
SELECT COUNT(user_id) AS user_downloads
FROM signups
;

-- number of users that requested a ride [12,406]
SELECT COUNT(DISTINCT user_id) AS users_ride_requested
FROM ride_requests
WHERE request_ts IS NOT NULL
;

-- number of users completed a ride [6,233]
SELECT COUNT(DISTINCT user_id) AS users_ride_completed
FROM ride_requests
WHERE dropoff_ts IS NOT NULL
;

-- number of users that paid for the ride [6,233]
SELECT COUNT(DISTINCT rid.user_id) AS users_ride_paid

FROM ride_requests rid
LEFT JOIN transactions tran USING(ride_id)
WHERE transaction_ts IS NOT NULL AND charge_status = 'Approved'
;

-- number of users that reviewed a ride [4,348]
SELECT COUNT(DISTINCT user_id) AS users_ride_reviewed
from reviews
;

/*   This is a combination/Aggregation of the queries above .
USER LEVEL GRANULARITY (DETAILS) - Funnel Analysis for a ride sharing company Metrocar similar to Uber and Lyft*/

SELECT COUNT(DISTINCT dow.app_download_key) AS total_users_download,
COUNT(sig.user_id) AS user_signups,

	(SELECT COUNT (DISTINCT user_id) AS total_users_ride_requested
			FROM ride_requests
			WHERE request_ts IS NOT NULL),
      
 (SELECT COUNT(DISTINCT user_id) AS total_users_ride_accepted
		FROM ride_requests
		WHERE accept_ts IS NOT NULL),

	(SELECT COUNT(DISTINCT user_id) AS total_users_ride_completed
	FROM ride_requests
	WHERE dropoff_ts IS NOT NULL),
  
  (SELECT COUNT(DISTINCT rid.user_id) AS total_users_ride_paid
		FROM ride_requests rid
		LEFT JOIN transactions tran USING(ride_id)
		WHERE transaction_ts IS NOT NULL AND charge_status = 'Approved'),
    
    (SELECT COUNT(DISTINCT user_id) AS total_users_ride_reviewed
					FROM reviews)

      
      
FROM app_downloads dow
LEFT JOIN signups sig ON dow.app_download_key = sig.session_id
;
