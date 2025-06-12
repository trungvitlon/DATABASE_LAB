DROP DATABASE IF EXISTS restaurant_db_v2;
CREATE DATABASE restaurant_db_v2;
\c restaurant_db_v2

-- ================
-- TABLE DEFINITION
-- ================
-- Customer
CREATE TABLE customer (
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(20) NOT NULL,
	phone_number VARCHAR(10) NOT NULL,
	card_point INT,
	note TEXT
);

-- Table
CREATE TABLE restaurant_table (
	table_id INT PRIMARY KEY,
	number_seats INT,
	status VARCHAR(20) NOT NULL
);

-- Reservation
CREATE TABLE reservation (
	reservation_id INT PRIMARY KEY,
	customer_id INT,
	table_id INT NOT NULL,
	reserved_time TIME,
	start_time TIME,
	end_time TIME,
	status VARCHAR(10),
	total_amount NUMERIC(10,2),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (table_id) REFERENCES restaurant_table(table_id)
);

-- Orders
CREATE TABLE orders (
	order_id INT PRIMARY KEY,
	reservation_id INT NOT NULL,
	order_time TIME,
	FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id)
);

-- Category
CREATE TABLE category (
	category_id INT PRIMARY KEY,
	category_name VARCHAR(20) NOT NULL,
	description TEXT
);

-- Menu Item
CREATE TABLE menu_item (
	menu_item_id INT PRIMARY KEY,
	category_id INT NOT NULL,
	menu_item_name VARCHAR(50) NOT NULL,
	price NUMERIC(10,2) CHECK (price > 0),
	FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- Order Detail
CREATE TABLE order_detail (
	order_detail_id INT PRIMARY KEY,
	order_id INT NOT NULL,
	menu_item_id INT NOT NULL,
	quantity INT CHECK (quantity > 0),
	FOREIGN KEY (order_id) REFERENCES orders(order_id),
	FOREIGN KEY (menu_item_id) REFERENCES menu_item(menu_item_id)
);

-- Role
CREATE TABLE role (
	role_id INT PRIMARY KEY,
	role_name VARCHAR(20) NOT NULL,
	salary NUMERIC(10,2) NOT NULL CHECK (salary >= 0),
	description TEXT
);

-- Shift
CREATE TABLE shift (
	shift_id INT PRIMARY KEY,
	shift_name VARCHAR(20) NOT NULL,
	start_time TIME,
	end_time TIME
);

-- Employee
CREATE TABLE employee (
	employee_id INT PRIMARY KEY,
	role_id INT NOT NULL,
	employee_name VARCHAR(50) NOT NULL,
	phone_number VARCHAR(10),
	email VARCHAR(50) CHECK (email LIKE '%@%'),
	FOREIGN KEY (role_id) REFERENCES role(role_id)
);

-- Payment
CREATE TABLE payment (
	payment_id INT PRIMARY KEY,
	reservation_id INT NOT NULL,
	payment_method VARCHAR(20),
	final_price NUMERIC(10,2),
	FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id)
);

-- Schedule 
CREATE TABLE schedule (
	schedule_id INT PRIMARY KEY,
	employee_id INT NOT NULL,
	shift_id INT NOT NULL,
	FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
	FOREIGN KEY (shift_id) REFERENCES shift(shift_id)
);

-- ===========
-- SAMPLE DATA 
-- ===========
INSERT INTO customer VALUES
(1, 'John Doe', '0912345678', 1, 'Allergic to peanuts'),
(2, 'Jane Smith', '0987654321', 0, NULL),
(3, 'Alice Nguyen', '0901122334', 1, 'VIP customer'),
(4, 'Bob Tran', '0922334455', 0, NULL),
(5, 'Emma Le', '0933445566', 2, 'Birthday today');

INSERT INTO restaurant_table VALUES
(1, 2, 'Available'),
(2, 4, 'Occupied'),
(3, 6, 'Reserved'),
(4, 8, 'Available'),
(5, 12, 'Reserved');

INSERT INTO category VALUES
(1, 'Japanese', NULL),
(2, 'Grill', NULL),
(3, 'Soup', NULL),
(4, 'Dessert', NULL),
(5, 'Western', NULL);

INSERT INTO menu_item VALUES
(1, 1, 'Tuna', 6.00),
(2, 2, 'Beef Steak', 12.00),
(3, 3, 'Chiken Soup', 4.00),
(4, 4, 'Ice Cream', 3.00),
(5, 5, 'Fruit Salad', 5.00);

INSERT INTO role VALUES
(1, 'Chef', 2000.00, 'Handles cooking'),
(2, 'Waiter', 1200.00, 'Serves customers'),
(3, 'Manager', 3000.00, 'Oversees restaurant'),
(4, 'Cleaner', 1000.00, 'Cleans tables and floor'),
(5, 'Cashier', 1500.00, 'Handles payment');

INSERT INTO shift VALUES
(1, 'Morning', '08:00', '12:00'),
(2, 'Afternoon', '12:00', '16:00'),
(3, 'Evening', '16:00', '20:00'),
(4, 'Night', '20:00', '00:00'),
(5, 'Full', '08:00', '20:00');

INSERT INTO employee VALUES
(1, 1, 'Thomas Nguyen', '0901111222', 'thomas@example.com'),
(2, 2, 'Linh Tran', '0903333444', 'linh@example.com'),
(3, 3, 'Hoa Le', '0905555666', 'hoa@example.com'),
(4, 4, 'Tung Pham', '0907777888', 'tung@example.com'),
(5, 5, 'Minh Vu', '0909999000', 'minh@example.com');

-- ============
-- ADD FUNCTION
-- ============
-- CUSTOMER
CREATE OR REPLACE FUNCTION add_customer(
    p_customer_name VARCHAR,
    p_phone_number VARCHAR
)
RETURNS VOID AS $$
DECLARE
    new_id INT;
BEGIN
    SELECT COALESCE(MAX(customer_id), 0) + 1 INTO new_id FROM customer;

    INSERT INTO customer (customer_id, customer_name, phone_number, card_point)
    VALUES (new_id, p_customer_name, p_phone_number, 0);
END;
$$ LANGUAGE plpgsql;

-- CATEGORY 
CREATE OR REPLACE FUNCTION add_category(
	p_category_name VARCHAR
)
RETURNS VOID AS $$ 
DECLARE 
	new_category_id INT;
BEGIN
	SELECT COALESCE(MAX(category_id), 0) + 1 INTO new_category_id FROM category;

	INSERT INTO category(category_id, category_name)
	VALUES (new_category_id, p_category_name);
END;
$$ LANGUAGE plpgsql;

-- MENU ITEM
CREATE OR REPLACE FUNCTION add_menu_item(
	p_category_id INT,
	p_menu_item_name VARCHAR,
	p_price NUMERIC
)
RETURNS VOID AS $$
DECLARE 
	new_menu_item_id INT;
BEGIN
	SELECT COALESCE(MAX(menu_item_id), 0) + 1 INTO new_menu_item_id FROM menu_item;

	INSERT INTO menu_item(menu_item_id, category_id, menu_item_name, price)
	VALUES (new_menu_item_id, p_category_id, p_menu_item_name, p_price);
END;
$$ LANGUAGE plpgsql;

-- TABLE
CREATE OR REPLACE FUNCTION add_table(
	p_number_seats INT
)
RETURNS VOID AS $$
DECLARE 
	new_table_id INT;
BEGIN
	SELECT COALESCE(MAX(table_id), 0) + 1 INTO new_table_id FROM restaurant_table;

	INSERT INTO restaurant_table(table_id, number_seats, status)
	VALUES (new_table_id, p_number_seats, 'Available');
END;
$$ LANGUAGE plpgsql;

-- ORDER
CREATE OR REPLACE FUNCTION add_order(
    p_reservation_id INT
)
RETURNS VOID AS $$
DECLARE
    new_order_id INT;
BEGIN
    SELECT COALESCE(MAX(order_id), 0) + 1 INTO new_order_id FROM orders;

	INSERT INTO orders(order_id, reservation_id, order_time)
    VALUES (new_order_id, p_reservation_id, current_time);
END;
$$ LANGUAGE plpgsql;

-- ORDER DETAIL
CREATE OR REPLACE FUNCTION add_order_detail(
	p_order_id INT,
    p_menu_item_id INT,
    p_quantity INT
)
RETURNS VOID AS $$
DECLARE
	new_order_detail_id INT;
BEGIN
    SELECT COALESCE(MAX(order_detail_id), 0) + 1 INTO new_order_detail_id FROM order_detail;

	INSERT INTO order_detail(order_detail_id, order_id, menu_item_id, quantity)
	VALUES (new_order_detail_id, p_order_id, p_menu_item_id, p_quantity);

END;
$$ LANGUAGE plpgsql;

-- PAYMENT
CREATE OR REPLACE FUNCTION add_payment(
	p_reservation_id INT,
	p_payment_method VARCHAR
)
RETURNS VOID AS $$
DECLARE
	new_payment_id INT;
	new_final_price NUMERIC;
BEGIN
	SELECT COALESCE(MAX(payment_id), 0) + 1 INTO new_payment_id FROM payment;

	SELECT total_amount * 1.05
	INTO new_final_price
	FROM reservation r
	WHERE r.reservation_id = p_reservation_id
	AND r.status = 'Active';

	INSERT INTO payment(payment_id, reservation_id, payment_method, final_price)
	VALUES (new_payment_id, p_reservation_id, p_payment_method, new_final_price);
END;
$$ LANGUAGE plpgsql;

-- EMPLOYEE
CREATE OR REPLACE FUNCTION add_employee(
	p_role_id INT,
	p_employee_name VARCHAR
)
RETURNS VOID AS $$
DECLARE
	new_employee_id INT;
BEGIN 
	SELECT COALESCE(MAX(employee_id), 0) + 1 INTO new_employee_id FROM employee;

	INSERT INTO employee(employee_id, role_id, employee_name)
	VALUES (new_employee_id, p_role_id, p_employee_name);
END;
$$ LANGUAGE plpgsql;

-- SCHEDULE
CREATE OR REPLACE FUNCTION add_schedule(
	p_employee_id INT,
	p_shift_id INT
)
RETURNS VOID AS $$
DECLARE
	new_schedule_id INT;
BEGIN
	SELECT COALESCE(MAX(schedule_id), 0) + 1 INTO new_schedule_id FROM schedule;

	INSERT INTO schedule(schedule_id, employee_id, shift_id)
	VALUES (new_schedule_id, p_employee_id, p_shift_id);
END;
$$ LANGUAGE plpgsql;

-- ===============
-- ORTHER FUNCTION
-- ===============
CREATE OR REPLACE FUNCTION find_table()
RETURNS TABLE (
	table_id INT,
	number_seats INT,
	table_status VARCHAR
) AS $$
BEGIN 
	RETURN QUERY
	SELECT r.table_id, r.number_seats, r.status
	FROM restaurant_table r
	WHERE r.status = 'Available'
	ORDER BY r.table_id ASC;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION reserved_table(p_table_id INT) 
RETURNS VOID AS $$ 
BEGIN
	UPDATE restaurant_table
	SET status = 'Reserved'
	WHERE table_id = p_table_id
	AND status != 'Reserved';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_reservation_table(p_reservation_id INT, p_customer_id INT)
RETURNS VOID AS $$ 
BEGIN 
	UPDATE reservation
	SET customer_id = p_customer_id,
	    start_time = CURRENT_TIME,
	    status = 'Active'
	WHERE reservation_id = p_reservation_id;
END;
$$ LANGUAGE plpgsql;

-- =======
-- TRIGGER
-- =======
CREATE OR REPLACE FUNCTION add_reservation()
RETURNS TRIGGER AS $$
DECLARE
    new_reservation_id INT;
BEGIN
    SELECT COALESCE(MAX(reservation_id), 0) + 1 INTO new_reservation_id FROM reservation;

    INSERT INTO reservation(reservation_id, customer_id, table_id, reserved_time, start_time, end_time, status, total_amount)
    VALUES (new_reservation_id, NULL, NEW.table_id, current_time, NULL, NULL, 'Pending', 0.00);
	
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER af_add_reservation
AFTER UPDATE on restaurant_table
FOR EACH ROW
WHEN (NEW.status = 'Reserved')
EXECUTE FUNCTION add_reservation();

CREATE OR REPLACE FUNCTION update_reservation()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE reservation r
    SET total_amount = total_amount + (
        SELECT price * NEW.quantity
        FROM menu_item
        WHERE menu_item.menu_item_id = NEW.menu_item_id
    )
    WHERE r.reservation_id = (
        SELECT o.reservation_id
        FROM orders o
        WHERE o.order_id = NEW.order_id
		AND status = 'Active'
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER af_insert_order_detail
AFTER INSERT on order_detail 
FOR EACH ROW
WHEN (NEW.order_detail_id IS NOT NULL)
EXECUTE FUNCTION update_reservation();

CREATE OR REPLACE FUNCTION tf_af_add_payment()
RETURNS TRIGGER AS $$
BEGIN
	UPDATE reservation r
	SET status = 'Paid',
		end_time = CURRENT_TIME
	WHERE r.reservation_id = NEW.reservation_id;

	UPDATE restaurant_table t
	SET status = 'Available'
	WHERE t.table_id = (
		SELECT table_id
		FROM reservation r
		WHERE r.reservation_id = NEW.reservation_id
	);

	UPDATE customer c
	SET card_point = card_point + NEW.final_price * 0.1
	WHERE c.customer_id = (
		SELECT customer_id
		FROM reservation r
		WHERE r.reservation_id = NEW.reservation_id
	);
	
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER af_add_payment
AFTER INSERT ON payment
FOR EACH ROW 
WHEN (NEW.payment_id IS NOT NULL)
EXECUTE FUNCTION tf_af_add_payment()
