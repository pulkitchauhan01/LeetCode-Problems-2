
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

3. Sales Analysis III

SELECT
    product_id,
    product_name
FROM Product
WHERE product_id IN (
    SELECT
        product_id
    FROM Sales
    GROUP BY product_id
    HAVING MIN(sale_date) >= '2019-01-01' AND MAX(sale_date) <= '2019-03-31'
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

2. Top Travellers

SELECT
    u.name,
    IFNULL(SUM(r.distance),0) AS travelled_distance
FROM Users u
LEFT JOIN Rides r
ON  u.id = r.user_id
GROUP BY r.user_id
ORDER BY travelled_distance DESC, u.name;

3. Market Analysis I (Special Case)

SELECT
    u.user_id AS buyer_id,
    u.join_date,
    IFNULL(COUNT(o.buyer_id),0) AS orders_in_2019
FROM users u
LEFT JOIN orders o
ON u.user_id = o.buyer_id
AND YEAR(o.order_date) = 2019
GROUP BY u.user_id;

* PLEASE NOTE: IN ABOVE QUERY AND IS USED INSTEAD OF WHERE CLAUSE - THIS IS BECAUSE THE TABLE HAD SOME USERS WHO DID NOT ORDER IN 2019, IF WE USE WHERE, THESE USERS WILL GET FILTERED OUT BUT WE NEED TO SHOW THESE USERS WITH 0 ORDERS IN 2019, SO WE USED AND.

4. Sales Analysis III

SELECT
    p.product_id,
    p.product_name
FROM Product p
JOIN Sales s
ON p.product_id = s.product_id
GROUP BY p.product_id
HAVING MIN(sale_date) >= '2019-01-01' AND MAX(sale_date) <= '2019-03-31';



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



Type: Temporary Table

1. Market Analysis I

SELECT
    u.user_id AS buyer_id,
    u.join_date,
    IFNULL(t.orders_placed,0) AS orders_in_2019
FROM users u
LEFT JOIN (
    
    SELECT
    buyer_id,
    COUNT(*) AS orders_placed
    FROM orders
    WHERE YEAR(order_date) = 2019
    GROUP BY buyer_id

) AS t
ON u.user_id = t.buyer_id;



Type: Join and Group BY

1. Bank Account Summary II

SELECT
    u.name,
    SUM(t.amount) AS balance
FROM Users u
JOIN Transactions t
ON u.account = t.account
GROUP BY u.name
HAVING balance > 10000;

PLEASE NOTE: UNLIKE WHERE CLAUSE, WE CAN USE ALIAS OF AGGREGATE FUNCTIONS IN HAVING CLAUSE.
