SELECT * FROM adashi_staging.savings_savingsaccount;

-- This section is to join the plans_plan table, savings table and users table

SELECT uc.first_name, uc.last_name, pp.is_regular_savings, pp.is_a_fund, ss.amount
FROM adashi_staging.plans_plan pp
INNER JOIN adashi_staging.savings_savingsaccount  ss
	ON pp.owner_id = ss.owner_id
INNER JOIN adashi_staging.users_customuser uc
	ON uc.id = ss.owner_id;


-- using CTE, 

WITH high_value_customer  AS 
(
SELECT pp.owner_id, concat(uc.first_name, ' ', uc.last_name) as `name`,
			pp.is_regular_savings, pp.is_a_fund, ss.confirmed_amount
FROM adashi_staging.plans_plan pp
INNER JOIN adashi_staging.savings_savingsaccount  ss
	ON pp.owner_id = ss.owner_id
INNER JOIN adashi_staging.users_customuser uc
	ON uc.id = ss.owner_id
)

SELECT *
FROM high_value_customer;


/* THis code below couldn't give me an output as MYSQl kept returning "Lost Connection to MYSQL server during query" */

-- But this was what i was trying to achieve

/*
-- performing rolling total on the confirmed amount to obtain the total deposit

 WITH high_value_customer  AS 
(
SELECT pp.owner_id, concat(uc.first_name, ' ', uc.last_name) as `name`,
			pp.is_regular_savings, pp.is_a_fund, ss.confirmed_amount
FROM adashi_staging.plans_plan pp
	INNER JOIN adashi_staging.savings_savingsaccount  ss
			ON pp.owner_id = ss.owner_id
	INNER JOIN adashi_staging.users_customuser uc
			ON uc.id = ss.owner_id
),
			-- this second CTE with table_name (rolling_total_confirmed_amount) is to get the sum for each unique oener_id 
            
rolling_total_confirmed_amount AS -- this is to perform a rolling sum total for the confirmed_amount
(
	SELECT *, sum(ss.confirmed_amount) over(partition by owner_id) as total_deposit
FROM high_value_customer;
)

SELECT *
FROM tolling_total_confirmed_amount;

*/

