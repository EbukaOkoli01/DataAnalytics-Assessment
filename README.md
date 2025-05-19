# DataAnalytics-Assessment

Question 1: Query to find customer with atleast one funded savings plan AND one funded plan sorted by total deposits

 For this Question 1, in other to approach it,
    FIRSTLy, I had to first use the INNER JOIN to combine the rqiired tables .plans_plan table , .savings_savingsaccount table, and 
          .users_customuser table. 
    SECONDLY, I use aliases (AS) to represent the tables, PP for plans table, SS for savings and UC for user table. This was done to 
          to avoid long names.
    Thirdly, In the tables provided, I had to use the function 'CONCAT' to join the first_name and last_name because i needed the full 
          name in one column.
    Lastly, I used Common Table Expression approach to solve the question because i needed to filter the table result after getting
          the outputs of the joined tables as I only needed a few columns in it.

  Challenges faced in this Question 1
        1. There were errors in the name column table but due to timing, I had to use the concatenation function as with aliases, I 
        represented it with name
        2. I had difficulty outputing only one row for the maximum value for the owner_id since I was using the window function.
           As window function does the calculation over the stated partition by column.

  For Q2. Obtain average number of transactions made by each customer on monthly basis
      To begin with, I joined the user table with th savings table, sice the ID column in savings table is similar to OWNER_ID 
          column in the user table. After achieving this, I had to use another CTE called transaction_frequency so that
          I can filter the excess columns obtained when i joined the tables to just the name then i did the AVERAGE of the
          transaction_date.
      Moreover, After performing average of transacion_date, I grouped by 'full_name'. This is so as to ensure all customers name 
        are grouped together regardless of when the transaction was performed. With this, I was able to now us a CASE state inside a 
        CTE to now group the result from the average transaction_date performed into HIGH, MEDIUM and LOW as stated in the requirement.
  
  Difficulties Experienced
    I was unable to obtain one row value for the average_transaction_per_month.
  
  For Q3. 
      I joined the tables savings and plans. Before doing this, I had to obtain the maximum transaction date in the table. This 
        was done to know the last date transaction was performed by any of the customers, once it was obtained to be 2025-04-18, I did a 
        a manual backdating and got 365 days away from 2025-04-18 was exactly 2024-04-18. With this, I was able to start the question.
      Secondly, using a CTE_in_CTE, this is so I could easily get the period of inactivity where I made CONFIRMED_AMOUNT = 0. With 
                this, I went on to use another CTE but now is to to make values of where column "is_regular_savings" = 1 to be svaings
                and values of column "is_a_fund" = 1, to be investment.
      Finally, Using the one of the window function 'row_number()', I was able to number the rows for each indiviual. This was done to
                know the number of inactive days.
                
  For Q4.
    Aside joining table, I use the Time Stamp Difference to get the difference between the date user registered and now. Also, Count(*), was to count accross the rows and returns 
    the total number of rows in the output result.
    
