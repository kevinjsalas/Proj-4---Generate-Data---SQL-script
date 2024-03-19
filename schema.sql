DROP SCHEMA IF EXISTS SuperStore;
CREATE SCHEMA SuperStore;
USE SuperStore;

-- Create the address table
CREATE TABLE address (
  address_id INT AUTO_INCREMENT PRIMARY KEY,
  street VARCHAR(100),
  city VARCHAR(100),
  state VARCHAR(100),
  zip VARCHAR(100)
) AUTO_INCREMENT = 1;

-- Create the product table
CREATE TABLE product (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(100),
  description TEXT,
  weight DECIMAL(10,2),
  base_cost DECIMAL(10,2)
) AUTO_INCREMENT = 1;

-- Create the customer table
CREATE TABLE customer (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(100),
  phone VARCHAR(100),
  address_id INT,
  FOREIGN KEY (address_id) REFERENCES address(address_id)
) AUTO_INCREMENT = 1;

-- Create the order table
CREATE TABLE order_table (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  address_id INT,
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY (address_id) REFERENCES address(address_id)
) AUTO_INCREMENT = 1;

-- Create the order_item table
CREATE TABLE order_item (
  order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES order_table(order_id),
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Create the warehouse table
CREATE TABLE warehouse (
  warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  address_id INT,
  FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- Create the product_warehouse table
CREATE TABLE product_warehouse (
  product_id INT,
  warehouse_id INT,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id)
);
