
WITH transaction_frequency_analysis AS -- First CTE to Join Tables
(
SELECT ss.transaction_date, substring(transaction_date, 6,2) as tran_month, 
							uc.first_name, uc.last_name, CONCAT(first_name, ' ', last_name) as full_name
FROM adashi_staging.savings_savingsaccount  ss
	INNER JOIN adashi_staging.users_customuser uc
			ON uc.id = ss.owner_id
) ,
transaction_frequency AS -- This second CTE is to easily filter the columnslisted in the first to just 2
(
SELECT full_name, AVG(tran_month) as average_transaction_per_month
FROM transaction_frequency_analysis
GROUP BY full_name
), 
frequency_analysis AS -- This CTE is to use CASE statement to easily classify the transaction by customers per month
(
SELECT *,
CASE
	WHEN average_transaction_per_month <=2 THEN 'Low Transaction'
    WHEN average_transaction_per_month >=3 and average_transaction_per_month <=9 THEN 'Medium Frequency'
    WHEN average_transaction_per_month >= 10 THEN 'High Frequency'
END AS frequency_category
from transaction_frequency
order by average_transaction_per_month
)

SELECT frequency_category, full_name,  average_transaction_per_month
FROM frequency_analysis
;


