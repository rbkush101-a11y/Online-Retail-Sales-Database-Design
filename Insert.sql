-- Customers (3 sample customers)
INSERT INTO customer (first_name, last_name, email, phone) VALUES
('Rishabh', 'Kushwaha', 'rishabh@example.com', '+917880345475'),
('Anjali', 'Verma', 'anjali.verma@example.com', '+919876543210'),
('Suresh', 'Sharma', 'suresh@example.com', NULL);

-- Products (4 sample products)
INSERT INTO product (sku, name, description, price, category) VALUES
('SKU-1001', 'Wireless Mouse', 'Ergonomic wireless mouse', 499.00, 'Electronics'),
('SKU-1002', 'Mechanical Keyboard', 'Blue switches mechanical keyboard', 2499.00, 'Electronics'),
('SKU-2001', 'Stainless Water Bottle', '1L insulated bottle', 799.00, 'Home & Kitchen'),
('SKU-3001', 'Yoga Mat', '6mm non-slip yoga mat', 999.00, 'Fitness');

-- Inventory (matching products)
INSERT INTO inventory (product_id, quantity_in_stock) VALUES
(1, 150),
(2, 60),
(3, 200),
(4, 120);

-- Create an order for Rishabh (order_id will be 1)
INSERT INTO `orders` (customer_id, shipping_address, status) VALUES
(1, '123 MG Road, Bengaluru, Karnataka, 560001', 'COMPLETED');

-- Add order items for order 1 (Rishabh bought 1 mouse and 1 keyboard)
INSERT INTO order_item (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 499.00),
(1, 2, 1, 2499.00);

-- Update orders.total_amount based on order_item line totals (simple update)
UPDATE `orders` o
SET total_amount = (
  SELECT IFNULL(SUM(oi.quantity * oi.unit_price), 0) FROM order_item oi WHERE oi.order_id = o.order_id
)
WHERE o.order_id = 1;

-- Create payment for order 1
INSERT INTO payment (order_id, amount, method, status, transaction_ref) VALUES
(1, 2998.00, 'CARD', 'SUCCESS', 'TXN-20251021-0001');

-- Create a second order (Anjali) with multiple quantities
INSERT INTO `orders` (customer_id, shipping_address, status) VALUES
(2, '45 Park Street, Kolkata, 700016', 'PENDING');

INSERT INTO order_item (order_id, product_id, quantity, unit_price) VALUES
(2, 3, 2, 799.00),  -- 2 bottles
(2, 4, 1, 999.00);  -- 1 yoga mat

UPDATE `orders` o
SET total_amount = (
  SELECT IFNULL(SUM(oi.quantity * oi.unit_price), 0) FROM order_item oi WHERE oi.order_id = o.order_id
)
WHERE o.order_id = 2;

-- No payment yet for order 2 (PENDING)

