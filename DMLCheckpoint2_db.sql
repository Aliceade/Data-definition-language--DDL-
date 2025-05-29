CREATE DATABASE IF NOT EXISTS dmlstore_db;
USE dmlstore_db;

-- Create customer table
CREATE TABLE customer (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_tel VARCHAR(20)
);

-- Create product table
CREATE TABLE product (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(20), 
    price DECIMAL(10, 2) NOT NULL
);

-- Create orders table
CREATE TABLE orders (
    customer_id VARCHAR(20),
    product_id VARCHAR(20),
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    order_date DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (customer_id, product_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Insert data into the customer table
INSERT INTO customer (customer_id, customer_name, customer_tel) VALUES
('C01', 'ALI', '71321009'),
('C02', 'ASMA', '77345823');

-- Insert data into the product table
-- Extracting category from the product name as per your data layout
INSERT INTO product (product_id, product_name, category, price) VALUES
('P01', 'Samsung Galaxy S20', 'Smartphone', 3299.00),
('P02', 'ASUS Notebook', 'PC', 4599.00);

-- Insert data into the orders table
-- For C01, P02, the order_date will use the default CURRENT_DATE() 
INSERT INTO orders (customer_id, product_id, quantity, total_amount) VALUES
('C01', 'P02', 2, 9198.00);

-- For C02, P01, the exact order_date in YYYY-MM-DD format
INSERT INTO orders (customer_id, product_id, order_date, quantity, total_amount) VALUES
('C02', 'P01', '2020-05-28', 1, 3299.00);
