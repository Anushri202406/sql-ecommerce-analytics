-- Drop tables if they exist
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- Create tables
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert data
INSERT INTO customers VALUES 
(1, 'Rohan Sharma', 'Kolkata'),
(2, 'Priya Singh', 'Delhi'),
(3, 'Amit Das', 'Kolkata'),
(4, 'Sneha Roy', 'Mumbai');

INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 50000),
(2, 'Mouse', 'Electronics', 500),
(3, 'Book - SQL', 'Books', 400),
(4, 'Keyboard', 'Electronics', 1500);

INSERT INTO orders VALUES
(1, 1, '2026-01-15', 50500),
(2, 2, '2026-02-10', 400),
(3, 3, '2026-02-20', 1500),
(4, 1, '2026-03-05', 50000);

INSERT INTO order_items VALUES
(1, 1, 1, 1),  -- Order 1: Laptop
(2, 1, 2, 1),  -- Order 1: Mouse
(3, 2, 3, 1),  -- Order 2: Book
(4, 3, 4, 1),  -- Order 3: Keyboard
(5, 4, 1, 1);  -- Order 4: Laptop