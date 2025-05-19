 WITH customer_tenure AS 
( 
SELECT id as customer_id, concat(first_name, ' ', last_name) as `name`,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months -- Calculate tenure in months
FROM adashi_staging.users_customuser
), 
transaction_summary AS
(
 SELECT owner_id, COUNT(*) AS total_transactions, AVG(confirmed_amount) AS avg_transaction_value
 FROM adashi_staging.savings_savingsaccount
GROUP BY owner_id
)

SELECT ct.customer_id, `name`, ct.tenure_months, ts.total_transactions,
    (ts.total_transactions / ct.tenure_months) * 12 * (ts.avg_transaction_value * 0.001) AS estimated_clv
FROM customer_tenure ct
JOIN TransactionSummary ts 
    ON ct.customer_id = ts.owner_id
WHERE ct.tenure_months > 0 
order by estimated_clv DESC;