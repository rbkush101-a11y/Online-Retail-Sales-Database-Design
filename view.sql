-- Query: Total revenue from successful payments
SELECT SUM(amount) AS total_revenue
FROM payment
WHERE status = 'SUCCESS';

SELECT
  o.order_id,
  o.order_date,
  c.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  o.status AS order_status,
  oi.order_item_id,
  p.product_id,
  p.name AS product_name,
  oi.quantity,
  oi.unit_price,
  oi.line_total,
  o.total_amount
FROM `orders` o
JOIN customer c ON c.customer_id = o.customer_id
JOIN order_item oi ON oi.order_id = o.order_id
JOIN product p ON p.product_id = oi.product_id
ORDER BY o.order_date DESC, o.order_id, oi.order_item_id;

SELECT p.product_id, p.name, p.sku, SUM(oi.quantity) AS total_units_sold
FROM order_item oi
JOIN product p ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name, p.sku
ORDER BY total_units_sold DESC
LIMIT 10;

SELECT
  DATE_FORMAT(payment_date, '%Y-%m'),
  SUM(amount) AS revenue
FROM payment
WHERE status = 'SUCCESS'
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY DATE_FORMAT(payment_date, '%Y-%m') DESC;

SELECT
  c.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  IFNULL(SUM(pmt.amount), 0) AS lifetime_value
FROM customer c
LEFT JOIN `orders` o ON o.customer_id = c.customer_id
LEFT JOIN payment pmt ON pmt.order_id = o.order_id AND pmt.status = 'SUCCESS'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY lifetime_value DESC;

CREATE OR REPLACE VIEW v_order_summary AS
SELECT
  o.order_id,
  o.order_date,
  o.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  o.status,
  o.total_amount,
  IFNULL(pmt.amount, 0) AS paid_amount,
  pmt.status AS payment_status
FROM `orders` o
LEFT JOIN customer c ON c.customer_id = o.customer_id
LEFT JOIN (
  SELECT order_id, SUM(amount) AS amount, MIN(status) AS status
  FROM payment
  GROUP BY order_id
) pmt ON pmt.order_id = o.order_id;

