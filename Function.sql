DELIMITER $$

CREATE FUNCTION get_order_total(orderID INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(12,2);
    SELECT IFNULL(SUM(quantity * unit_price), 0)
    INTO total
    FROM order_item
    WHERE order_id = orderID;
    RETURN total;
END $$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION get_customer_ltv(custID INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE ltv DECIMAL(12,2);
    SELECT IFNULL(SUM(p.amount), 0)
    INTO ltv
    FROM orders o
    JOIN payment p ON p.order_id = o.order_id
    WHERE o.customer_id = custID AND p.status = 'SUCCESS';
    RETURN ltv;
END $$

DELIMITER ;
