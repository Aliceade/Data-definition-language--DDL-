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