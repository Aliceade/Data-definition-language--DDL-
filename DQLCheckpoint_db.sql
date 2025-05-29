CREATE DATABASE IF NOT EXISTS onlinestore_db;
USE onlinestore_db;

-- Create customer table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_tel VARCHAR(20)
);

-- Create product table
CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Create orders table
CREATE TABLE orders (
    customer_id INT,
    product_id INT,
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (customer_id, product_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Add Category column to product table 
ALTER TABLE product
ADD category VARCHAR(20);

-- Add OrderDate column to orders table with current date as default
ALTER TABLE orders
ADD order_date DATE DEFAULT (CURRENT_DATE);

-- Insert customers
INSERT INTO customer (customer_id, customer_name, customer_tel) VALUES
(1, 'John Smith', '555-1234'),
(2, 'Emily Johnson', '555-5678'),
(3, 'Michael Brown', '555-9012'),
(4, 'Sarah Davis', '555-3456'),
(5, 'David Wilson', '555-7890');

-- Insert products
INSERT INTO product (product_id, product_name, price, category) VALUES
(101, 'Laptop', 8999.99, 'Electronics'),
(102, 'Smartphone', 5999.99, 'Electronics'),
(103, 'Headphones', 799.99, 'Accessories'),
(104, 'Tablet', 7499.99, 'Electronics'),
(105, 'Smart Watch', 2999.99, 'Accessories');

-- Insert orders (with some orders from 2020 and some recent)
INSERT INTO orders (customer_id, product_id, quantity, total_amount, order_date) VALUES
(1, 101, 1, 8999.99, '2020-01-15'),
(1, 102, 2, 11999.98, '2020-02-20'),
(2, 104, 1, 7499.99, '2020-03-10'),
(3, 101, 1, 8999.99, '2023-05-01'),
(3, 105, 3, 8999.97, '2023-06-10'),
(4, 102, 1, 5999.99, '2023-07-15'),
(5, 103, 5, 3999.95, '2020-04-05'),
(1, 104, 1, 7499.99, '2020-05-12'),
(2, 105, 2, 5999.98, '2023-08-20');

-- Display all data from the customer table
SELECT * FROM customer;

-- Display the product_name and category for products which their price is between 5000 and 10000 
SELECT product_name, category 
FROM product 
WHERE price BETWEEN 5000 AND 10000;

-- Display all the data of products sorted in descending order of price
SELECT * FROM product ORDER BY price DESC;

-- Display the total number of orders, the average amount, the highest total amount and the lower total amount
SELECT 
    COUNT(*) AS total_orders,
    AVG(total_amount) AS average_amount,
    MAX(total_amount) AS highest_amount,
    MIN(total_amount) AS lowest_amount
FROM orders;

-- For each product_id, display the number of orders
SELECT product_id, COUNT(*) AS order_count
FROM orders
GROUP BY product_id;

-- Display the customer_id which has more than 2 orders
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 2;

-- For each month of the 2020 year, display the number of orders
SELECT 
    MONTH(order_date) AS month,
    COUNT(*) AS order_count
FROM orders
WHERE YEAR(order_date) = 2020
GROUP BY MONTH(order_date)
ORDER BY month;

-- For each order, display the product_name, the customer_name and the date of the order
SELECT 
    p.product_name,
    c.customer_name,
    o.order_date
FROM orders o
JOIN product p ON o.product_id = p.product_id
JOIN customer c ON o.customer_id = c.customer_id;

-- Display all the orders made three months ago
SELECT *
FROM orders
WHERE order_date BETWEEN 
    DATE_SUB(DATE_FORMAT(NOW(), '%Y-%m-01'), INTERVAL 3 MONTH)
    AND LAST_DAY(DATE_SUB(NOW(), INTERVAL 3 MONTH));

-- Display customers (customer_id) who have never ordered a product
SELECT c.customer_id
FROM customer c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;