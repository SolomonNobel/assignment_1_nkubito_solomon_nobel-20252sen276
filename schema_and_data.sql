-- Clean up existing tables
DROP TABLE order_items CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE products CASCADE CONSTRAINTS;
DROP TABLE customers CASCADE CONSTRAINTS;

-- 1. Create Tables
CREATE TABLE customers (
  customer_id NUMBER PRIMARY KEY,
  customer_name VARCHAR2(100),
  email VARCHAR2(100),
  city VARCHAR2(50)
);

CREATE TABLE products (
  product_id NUMBER PRIMARY KEY,
  product_name VARCHAR2(100),
  category VARCHAR2(50),
  price NUMBER(10,2)
);

CREATE TABLE orders (
  order_id NUMBER PRIMARY KEY,
  customer_id NUMBER REFERENCES customers(customer_id),
  order_date DATE
);

CREATE TABLE order_items (
  order_item_id NUMBER PRIMARY KEY,
  order_id NUMBER REFERENCES orders(order_id),
  product_id NUMBER REFERENCES products(product_id),
  quantity NUMBER
);

-- 2. Populate Customers (5 total: 4 active, 1 with no orders)
INSERT INTO customers VALUES (101, 'Alice Johnson', 'alice@gmail.com', 'Kigali');
INSERT INTO customers VALUES (102, 'Bob Smith', 'bob@yahoo.com', 'Musanze');
INSERT INTO customers VALUES (103, 'Charlie Brown', 'charlie@gmail.com', 'Huye');
INSERT INTO customers VALUES (104, 'Diana Prince', 'diana@outlook.com', 'Kigali');
INSERT INTO customers VALUES (105, 'Edward Nygma', 'edward@riddler.com', 'Rubavu');

-- 3. Populate Products (8 total across 3 categories)
INSERT INTO products VALUES (1, 'Whole Milk 1L', 'Dairy', 2.50);
INSERT INTO products VALUES (2, 'Cheddar Cheese 250g', 'Dairy', 4.00);
INSERT INTO products VALUES (3, 'Greek Yogurt 500g', 'Dairy', 3.50);
INSERT INTO products VALUES (4, 'Whole Wheat Bread', 'Bakery', 2.00);
INSERT INTO products VALUES (5, 'Chocolate Croissant', 'Bakery', 1.80);
INSERT INTO products VALUES (6, 'Orange Juice 1L', 'Beverages', 3.00);
INSERT INTO products VALUES (7, 'Sparkling Water 500ml', 'Beverages', 1.20);
INSERT INTO products VALUES (8, 'Espresso Beans 250g', 'Beverages', 7.50);

-- 4. Populate Orders (15 orders)
INSERT INTO orders VALUES (1001, 101, TO_DATE('2026-08-01', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1002, 102, TO_DATE('2026-08-02', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1003, 101, TO_DATE('2026-08-05', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1004, 103, TO_DATE('2026-08-07', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1005, 104, TO_DATE('2026-08-10', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1006, 102, TO_DATE('2026-08-12', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1007, 101, TO_DATE('2026-08-15', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1008, 103, TO_DATE('2026-08-18', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1009, 104, TO_DATE('2026-08-20', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1010, 102, TO_DATE('2026-08-22', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1011, 101, TO_DATE('2026-08-25', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1012, 103, TO_DATE('2026-08-28', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1013, 104, TO_DATE('2026-09-01', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1014, 101, TO_DATE('2026-09-03', 'YYYY-MM-DD'));
INSERT INTO orders VALUES (1015, 102, TO_DATE('2026-09-05', 'YYYY-MM-DD'));

-- 5. Populate Order Items (25 order items)
INSERT INTO order_items VALUES (1,  1001, 1, 2);
INSERT INTO order_items VALUES (2,  1001, 4, 1);
INSERT INTO order_items VALUES (3,  1002, 8, 2);
INSERT INTO order_items VALUES (4,  1003, 2, 1);
INSERT INTO order_items VALUES (5,  1003, 6, 2);
INSERT INTO order_items VALUES (6,  1004, 3, 3);
INSERT INTO order_items VALUES (7,  1005, 5, 4);
INSERT INTO order_items VALUES (8,  1005, 7, 2);
INSERT INTO order_items VALUES (9,  1006, 1, 1);
INSERT INTO order_items VALUES (10, 1006, 2, 2);
INSERT INTO order_items VALUES (11, 1007, 8, 1);
INSERT INTO order_items VALUES (12, 1007, 4, 2);
INSERT INTO order_items VALUES (13, 1008, 6, 3);
INSERT INTO order_items VALUES (14, 1009, 1, 2);
INSERT INTO order_items VALUES (15, 1009, 3, 1);
INSERT INTO order_items VALUES (16, 1010, 8, 3);
INSERT INTO order_items VALUES (17, 1011, 5, 5);
INSERT INTO order_items VALUES (18, 1011, 7, 3);
INSERT INTO order_items VALUES (19, 1012, 2, 2);
INSERT INTO order_items VALUES (20, 1012, 4, 1);
INSERT INTO order_items VALUES (21, 1013, 8, 1);
INSERT INTO order_items VALUES (22, 1014, 1, 4);
INSERT INTO order_items VALUES (23, 1014, 6, 2);
INSERT INTO order_items VALUES (24, 1015, 3, 2);
INSERT INTO order_items VALUES (25, 1015, 5, 2);

COMMIT;
