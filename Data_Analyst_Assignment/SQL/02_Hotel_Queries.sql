-- Hotel Management System - Query Solutions

-- Query 1: Last booked room per user
SELECT 
    u.user_id,
    u.name,
    b.booking_id,
    b.room_no,
    MAX(b.booking_date) as last_booking_date
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id, u.name, b.room_no
ORDER BY u.user_id;

-- Query 2: Billing for November 2021
SELECT 
    b.booking_id,
    u.name,
    bc.bill_id,
    bc.bill_date,
    SUM(i.item_rate * bc.item_quantity) as total_bill_amount
FROM booking_commercials bc
JOIN bookings b ON bc.booking_id = b.booking_id
JOIN users u ON b.user_id = u.user_id
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 11 AND YEAR(bc.bill_date) = 2021
GROUP BY b.booking_id, u.name, bc.bill_id, bc.bill_date
ORDER BY total_bill_amount DESC;

-- Query 3: Bills > 1000 in October 2021
SELECT 
    bc.bill_id,
    b.booking_id,
    u.name,
    bc.bill_date,
    SUM(i.item_rate * bc.item_quantity) as total_bill_amount
FROM booking_commercials bc
JOIN bookings b ON bc.booking_id = b.booking_id
JOIN users u ON b.user_id = u.user_id
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10 AND YEAR(bc.bill_date) = 2021
GROUP BY bc.bill_id, b.booking_id, u.name, bc.bill_date
HAVING SUM(i.item_rate * bc.item_quantity) > 1000
ORDER BY total_bill_amount DESC;

-- Query 4: Most & least ordered item per month
WITH monthly_items AS (
    SELECT 
        YEAR(bc.bill_date) as year,
        MONTH(bc.bill_date) as month,
        i.item_name,
        SUM(bc.item_quantity) as total_quantity,
        ROW_NUMBER() OVER (PARTITION BY YEAR(bc.bill_date), MONTH(bc.bill_date) ORDER BY SUM(bc.item_quantity) DESC) as rank_desc,
        ROW_NUMBER() OVER (PARTITION BY YEAR(bc.bill_date), MONTH(bc.bill_date) ORDER BY SUM(bc.item_quantity) ASC) as rank_asc
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    GROUP BY YEAR(bc.bill_date), MONTH(bc.bill_date), i.item_name
)
SELECT 
    year,
    month,
    item_name,
    total_quantity,
    CASE 
        WHEN rank_desc = 1 THEN 'Most Ordered'
        WHEN rank_asc = 1 THEN 'Least Ordered'
    END as status
FROM monthly_items
WHERE rank_desc = 1 OR rank_asc = 1
ORDER BY year, month;

-- Query 5: Customers with second highest bill per month
WITH monthly_bills AS (
    SELECT 
        YEAR(bc.bill_date) as year,
        MONTH(bc.bill_date) as month,
        u.name,
        SUM(i.item_rate * bc.item_quantity) as bill_amount,
        ROW_NUMBER() OVER (PARTITION BY YEAR(bc.bill_date), MONTH(bc.bill_date) ORDER BY SUM(i.item_rate * bc.item_quantity) DESC) as rank
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN users u ON b.user_id = u.user_id
    JOIN items i ON bc.item_id = i.item_id
    GROUP BY YEAR(bc.bill_date), MONTH(bc.bill_date), u.name
)
SELECT 
    year,
    month,
    name,
    bill_amount
FROM monthly_bills
WHERE rank = 2
ORDER BY year, month;
