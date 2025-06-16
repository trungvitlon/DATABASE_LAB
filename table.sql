DROP DATABASE IF EXISTS restaurant_db_v2;
CREATE DATABASE restaurant_db_v2;
\c restaurant_db_v2

-- ================
-- TABLE DEFINITION
-- ================
-- Customer
CREATE TABLE customer (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20),
    birth_date DATE,
    phone_number VARCHAR(10) NOT NULL,
    address VARCHAR(20)
);

-- Role
CREATE TABLE role (
	role_id INT PRIMARY KEY,
	role_name VARCHAR(20) NOT NULL,
	salary NUMERIC(10,2) NOT NULL CHECK (salary >= 0)
);

-- Manager
CREATE TABLE manager (
	manager_id INT PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20),
    birth_date DATE,
    phone_number VARCHAR(10),
    address VARCHAR(20),
    start_date DATE
);

-- Branch
CREATE TABLE branch (
    branch_id INT PRIMARY KEY,
    phone_number VARCHAR(10),
    address VARCHAR(20),
    start_date DATE,
    manager_id INT NOT NULL,
    FOREIGN KEY (manager_id) REFERENCES manager(manager_id)
);

-- Employee
CREATE TABLE employee (
	employee_id INT PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20),
    birth_date DATE,
    phone_number VARCHAR(10),
    address VARCHAR(20),
    start_date DATE,
	role_id INT NOT NULL,
    branch_id INT NOT NULL,
	FOREIGN KEY (role_id) REFERENCES role(role_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Table
CREATE TABLE restaurant_table (
	table_id INT PRIMARY KEY,
	seat_count INT NOT NULL,
	status VARCHAR(20) NOT NULL,
    branch_id INT NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Reservation
CREATE TABLE reservation (
	reservation_id INT PRIMARY KEY,
    reserved_date DATE,
	reserved_time TIME,
	start_time TIME,
	end_time TIME,
	status VARCHAR(10),
	total_amount NUMERIC(10,2),
	customer_id INT,
	table_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (table_id) REFERENCES restaurant_table(table_id)
);

-- Category
CREATE TABLE category (
	category_id INT PRIMARY KEY,
	category_name VARCHAR(20) NOT NULL
);

-- Menu Item
CREATE TABLE menu_item (
	menu_item_id INT PRIMARY KEY,
	menu_item_name VARCHAR(50) NOT NULL,
	price NUMERIC(10,2) CHECK (price > 0),
    new_item VARCHAR(10),
	category_id INT NOT NULL,
	FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- Orders
CREATE TABLE orders (
	order_id INT PRIMARY KEY,
	order_time TIME,
	reservation_id INT NOT NULL,
	FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id)
);

-- Order Detail
CREATE TABLE order_detail (
	order_detail_id INT PRIMARY KEY,
	quantity INT CHECK (quantity > 0),
	menu_item_id INT NOT NULL,
	order_id INT NOT NULL,
	FOREIGN KEY (order_id) REFERENCES orders(order_id),
	FOREIGN KEY (menu_item_id) REFERENCES menu_item(menu_item_id)
);

-- Payment
CREATE TABLE payment (
	payment_id INT PRIMARY KEY,
	payment_method VARCHAR(20),
	final_price NUMERIC(10,2),
	reservation_id INT NOT NULL,
	FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id)
);