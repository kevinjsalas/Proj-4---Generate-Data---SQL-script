LOAD DATA INFILE '/Applications/XAMPP/xamppfiles/htdocs/CPSC 3220/Proj 4 - Generate Data : SQL script/address.txt'
INTO TABLE address
FIELDS TERMINATED BY ':'
LINES TERMINATED BY '\n'
(street, city, state, zip);

LOAD DATA INFILE '/Applications/XAMPP/xamppfiles/htdocs/CPSC 3220/Proj 4 - Generate Data : SQL script/customer.txt'
INTO TABLE customer
FIELDS TERMINATED BY ':'
LINES TERMINATED BY '\n'
(first_name, last_name, email, phone);

UPDATE customer
SET address_id = (
    SELECT address_id
    FROM address
    WHERE address_id IS NOT NULL
    ORDER BY RAND()
    LIMIT 1
)
WHERE address_id IS NULL;

INSERT INTO order_table (customer_id, address_id)
SELECT customer_id, address_id
FROM customer
ORDER BY RAND()
LIMIT 100;

INSERT INTO order_table (customer_id, address_id)
SELECT customer_id, address_id
FROM customer
ORDER BY RAND()
LIMIT 100;

INSERT INTO order_table (customer_id, address_id)
SELECT customer_id, address_id
FROM customer
ORDER BY RAND()
LIMIT 100;

INSERT INTO order_table (customer_id, address_id)
SELECT customer_id, address_id
FROM customer
ORDER BY RAND()
LIMIT 50;

LOAD DATA INFILE '/Applications/XAMPP/xamppfiles/htdocs/CPSC 3220/Proj 4 - Generate Data : SQL script/product.txt'
INTO TABLE product
FIELDS TERMINATED BY ':'
LINES TERMINATED BY '\n'
(product_name, description, weight, base_cost);

LOAD DATA INFILE '/Applications/XAMPP/xamppfiles/htdocs/CPSC 3220/Proj 4 - Generate Data : SQL script/warehouses.txt'
INTO TABLE warehouse
FIELDS TERMINATED BY '\n'
(name);

UPDATE warehouse
SET address_id = (
    SELECT address_id
    FROM customer
    WHERE address_id IS NOT NULL
    ORDER BY RAND()
    LIMIT 1
)
WHERE address_id IS NULL;

INSERT INTO order_item (product_id)
SELECT product_id
FROM product
ORDER BY RAND()
LIMIT 550;

UPDATE order_item
SET quantity = (SELECT FLOOR(RAND() * (50 - 10 + 1)) + 10)
WHERE quantity IS NULL;


UPDATE order_item oi
JOIN product p ON oi.product_id = p.product_id
SET oi.price = p.base_cost * oi.quantity;

UPDATE order_item
SET order_id = (
    SELECT order_id
    FROM order_table
    WHERE order_id IS NOT NULL
    ORDER BY RAND()
    LIMIT 1
)
WHERE order_id IS NULL;

INSERT INTO product_warehouse (product_id)
SELECT product_id
FROM product
ORDER BY RAND();

INSERT INTO product_warehouse (product_id)
SELECT product_id
FROM product
ORDER BY RAND()
LIMIT 500;

UPDATE product_warehouse
SET warehouse_id = (
    SELECT warehouse_id
    FROM warehouse
    WHERE warehouse_id IS NOT NULL
    ORDER BY RAND()
    LIMIT 1
)
WHERE warehouse_id IS NULL;
