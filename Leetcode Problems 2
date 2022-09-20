
Type: Subquery

1. Customer Who Visited but Did Not Make Any Transactions

SELECT 
    customer_id, 
    COUNT(v.visit_id) AS count_no_trans
FROM visits v
WHERE v.visit_id NOT IN
(SELECT visit_id FROM transactions) 
GROUP BY customer_id
ORDER BY customer_id DESC;


2. Sales Person

SELECT 
    s.name
FROM SalesPerson s
WHERE s.sales_id
NOT IN (
SELECT
    o.sales_id
FROM Orders o
JOIN Company c
ON o.com_id = c.com_id
WHERE c.name = "RED"
);


Type: Join

1. Customer Who Visited but Did Not Make Any Transactions

SELECT 
    customer_id, 
    COUNT(v.visit_id) AS count_no_trans
FROM visits v
LEFT JOIN transactions t
ON v.visit_id = t.visit_id
WHERE t.visit_id IS NULL
GROUP BY customer_id;



Type: Self-Join 

1. SELECT
    w1.id
FROM weather w1
JOIN weather w2
ON DATEDIFF(w1.recorddate,w2.recorddate) = 1
WHERE w1.temperature > w2.temperature;



Type: Date Conditions

1. User Activity for the Past 30 Days I

SELECT
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE DATEDIFF('2019-07-27',activity_date) < 30 AND DATEDIFF('2019-07-27',activity_date) >= 0
GROUP BY activity_date;



Type: Case inside Aggregation

1. Capital Gain/Loss

SELECT
    stock_name,
    SUM(
        CASE
            WHEN operation = "Buy" THEN price*(-1)
            ELSE price END
    ) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;








