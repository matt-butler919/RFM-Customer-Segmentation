SELECT 
	customerid,
    customername,
    last_order_year,
    frequency,
    monetary,
    
	CASE
    	WHEN last_order_year >= '2026' THEN 3
        WHEN last_order_year >= '2025' THEN 2
        ELSE 1
    END AS recency_score,
    
    CASE
    	WHEN frequency >= 9 THEN 3
        WHEN frequency >= 6 THEN 2
        ELSE 1
    END AS frequency_score,
    
    CASE
    	WHEN monetary >= 3500 THEN 3
        WHEN monetary >= 1750 THEN 2
        ELSE 1
    END AS monetary_score
FROM (
	SELECT
  		customerID,
  		customerName,
  		MAX(substr("orderDate", -4)) AS last_order_year,
  		COUNT(DISTINCT "orderID") AS frequency,
  		ROUND(SUM("Sales"), 2) AS monetary
  	FROM tableauSuperstore
  	GROUP BY "customerID", "customerName") AS rfm_base
    
ORDER BY monetary_score DESC, frequency_score DESC, recency_score DESC;