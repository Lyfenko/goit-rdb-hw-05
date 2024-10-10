SELECT id, order_id, product_id, quantity,
       (SELECT customer_id FROM orders WHERE id = order_id)
           AS customer_id FROM order_details;

SELECT * FROM order_details WHERE order_id IN ( SELECT id FROM orders WHERE shipper_id = 3 );

SELECT order_id, AVG(quantity) AS avg_quantity
FROM (
         SELECT order_id, quantity
         FROM order_details
         WHERE quantity > 10
     ) AS subquery
GROUP BY order_id;

WITH temp AS (
    SELECT order_id, quantity
    FROM order_details
    WHERE quantity > 10
)
SELECT order_id, AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;

DROP FUNCTION IF EXISTS divide_float;

DELIMITER //

CREATE FUNCTION divide_float(a FLOAT, b FLOAT) RETURNS FLOAT
    DETERMINISTIC
BEGIN
    RETURN a / b;
END//

DELIMITER ;

SELECT divide_float(quantity, 2.0) AS result
FROM order_details;