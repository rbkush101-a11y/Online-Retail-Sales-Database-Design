-- 0. Create and use a dedicated database for the project
CREATE DATABASE IF NOT EXISTS online_retail;
USE online_retail;

-- 1. Customer table: stores customer info
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,   -- unique identifier
    first_name VARCHAR(50) NOT NULL,              -- first name
    last_name VARCHAR(50) NOT NULL,               -- last name
    email VARCHAR(255) NOT NULL UNIQUE,           -- unique email
    phone VARCHAR(20),                             -- optional phone
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- record creation time
);

-- 2. Product table: catalog of products
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,    -- product id
    sku VARCHAR(50) NOT NULL UNIQUE,              -- stock keeping unit
    name VARCHAR(200) NOT NULL,                   -- product name
    description TEXT,                              -- full description
    price DECIMAL(10,2) NOT NULL,                  -- unit price
    category VARCHAR(100),                          -- product category
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. `orders` table: one row per order (order header)
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,       -- order id
    customer_id INT NOT NULL,                      -- FK to customer
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,  -- when order placed
    status VARCHAR(30) DEFAULT 'PENDING',          -- e.g., PENDING, SHIPPED, CANCELLED, COMPLETED
    shipping_address VARCHAR(500),                 -- shipping address text
    total_amount DECIMAL(12,2) DEFAULT 0.00,       -- cached total for convenience
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
      ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 4. Order item table: one row per product in an order (order line)
CREATE TABLE order_item (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,  -- order item id
    order_id INT NOT NULL,                         -- FK to orders
    product_id INT NOT NULL,                       -- FK to product
    quantity INT NOT NULL DEFAULT 1,               -- quantity ordered
    unit_price DECIMAL(10,2) NOT NULL,             -- price at time of order
    line_total DECIMAL(12,2) AS (quantity * unit_price) STORED,  -- computed column (MySQL)
    CONSTRAINT fk_item_order FOREIGN KEY (order_id) REFERENCES `orders`(order_id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_item_product FOREIGN KEY (product_id) REFERENCES product(product_id)
      ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 5. Payment table: one payment per order (simplified). Could support multiple payments if needed.
CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(12,2) NOT NULL,
    method VARCHAR(50) NOT NULL,    -- e.g., CARD, UPI, NETBANKING, COD
    status VARCHAR(30) DEFAULT 'SUCCESS', -- SUCCESS, FAILED, REFUNDED, PENDING
    transaction_ref VARCHAR(255),    -- external payment gateway reference
    CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES `orders`(order_id)
      ON DELETE CASCADE ON UPDATE CASCADE
);

-- 6. (Optional) inventory table: track stock levels
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL UNIQUE,
    quantity_in_stock INT NOT NULL DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_inventory_product FOREIGN KEY (product_id) REFERENCES product(product_id)
      ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. Helpful indexes (apart from PKs/unique): speed up common queries
CREATE INDEX idx_orders_customer ON `orders`(customer_id, order_date);
CREATE INDEX idx_order_item_product ON order_item(product_id);
CREATE INDEX idx_product_category ON product(category);

