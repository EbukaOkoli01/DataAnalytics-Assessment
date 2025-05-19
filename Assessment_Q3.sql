
/* To know the maximum date so we can now back date to get 365days*/
SELECT max(SUBSTRING(transaction_date, 1, 10)) 
FROM adashi_staging.savings_savingsaccount; -- maximum date 2025- 04- 18, minimum date will be 2024-04-18

--  Using Join, we can combine the plans and savings table 

WITH one_year_activity AS -- this shows period of activity and inactivity
(
SELECT ss.plan_id , ss.owner_id, substring(transaction_date, 1,10) as last_tran_date,
pp.is_regular_savings, pp.is_a_fund, ss.confirmed_amount
FROM adashi_staging.plans_plan pp
INNER JOIN adashi_staging.savings_savingsaccount ss
	ON pp.owner_id = ss.owner_id
WHERE transaction_date >= '2024-04-18' and transaction_date <= '2025-04-18' 
),
 one_year_inactivity AS -- This outputs periods of inctivity within th timeframe (365days from 2025-04-18)
(
SELECT *
FROM one_year_activity
WHERE confirmed_amount = 0
), 
sav_or_inv AS -- This section is to define the savings and investment 
(
SELECT *, 
CASE
	WHEN is_regular_savings = 1 THEN 'Savings'
    WHEN is_a_fund = 1 THEN 'Investment'
END AS `type`
FROM one_year_inactivity
),
row_day AS -- To know the days of inactivity, i had to use row_number 
(
SELECT *, row_number() over(partition by owner_id) as inactivity_row_day
FROM sav_or_inv
where `type` is not null -- removing all null in the column to only show the savings and investment
)
 
 SELECT plan_id, owner_id, last_tran_date, `type`,
		max(inactivity_row_day) over(partition by owner_id) as inactivity_days /* This shows only the maximum inactivity day for unique owner
																				owner_id */
 FROM row_day
;