DELIMITER $$

CREATE PROCEDURE add_order(
    IN p_customer_id INT,
    IN p_shipping_address VARCHAR(500),
    INOUT p_order_id INT
)
BEGIN
    -- 1. Insert order
    INSERT INTO orders(customer_id, shipping_address, status)
    VALUES (p_customer_id, p_shipping_address, 'PENDING');

    -- 2. Get the last inserted order_id
    SET p_order_id = LAST_INSERT_ID();
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE mark_order_paid(
    IN p_order_id INT,
    IN p_amount DECIMAL(12,2),
    IN p_method VARCHAR(50)
)
BEGIN
    INSERT INTO payment(order_id, amount, method, status)
    VALUES (p_order_id, p_amount, p_method, 'SUCCESS');

    UPDATE orders
    SET status = 'COMPLETED'
    WHERE order_id = p_order_id;
END $$

DELIMITER ;
