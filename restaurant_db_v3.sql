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

-- Shift
CREATE TABLE shift (
	shift_id INT PRIMARY KEY,
	shift_name VARCHAR(20) NOT NULL,
	start_time TIME,
	end_time TIME
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
-- customer(id, first_name, last_name, birth_date, phone_number, address)
INSERT INTO customer VALUES
(1, 'Tran', 'Viet', '1988-04-25', '0918726112', 'Ha Noi'),
(2, 'Nguyen', 'Duc', '1989-05-09', '0981763223', 'Hai Phong'),
(3, 'Dao', 'Anh', '1981-07-12', '0918726263', 'Ha Noi'),
(4, 'Tran', 'Minh', '1985-12-15', '0918723663', 'Da Nang'),
(5, 'Dao', 'Hoa', '1993-08-14', '0912651299', 'Hai Phong'),
(6, 'Le', 'Trang', '1995-11-11', '0967445176', 'Da Nang'),
(7, 'Nguyen', 'Hang', '1997-06-16', '0991271016', 'Hai Phong');

-- manager(id, first_name, last_name, birth_date, phone_number, address, start_date)
INSERT INTO manager VALUES
(1, 'Nguyen', 'Linh', '1981-10-20', '0918719212', 'Ha Noi', '2019-04-05'),
(2, 'Ho', 'Thuy', '1983-04-05', '0981782003', 'Hai Phong', '2020-07-17'),
(3, 'Hoang', 'Trung', '1982-03-14', '0918720163', 'Da Nang', '2021-01-13');

-- branch(id, phone_number, address, start_date, manager_id)
INSERT INTO branch VALUES 
(1, '0900447618', 'Ha Noi', '2019-05-21', 1),
(2, '0900441743', 'Hai Phong', '2018-02-01', 2),
(3, '0900441762', 'Da Nang', '2020-08-24', 3),
(4, '0900448712', 'Ha Noi', '2020-07-23', 1),
(5, '0900448712', 'Hai Phong', '2017-07-17', 2),
(6, '0900441264', 'Da Nang', '2022-03-15', 3);

-- table(id, seat_count, status, branch_id)
INSERT INTO restaurant_table VALUES
(1, 4, 'Available', 1),
(2, 4, 'Reserved', 3),
(3, 4, 'Available', 5),
(4, 4, 'Reserved', 2),
(5, 4, 'Available', 4),
(6, 8, 'Available', 6),
(7, 8, 'Available', 1),
(8, 8, 'Available', 3),
(9, 8, 'Available', 5),
(10, 12, 'Reserved', 2),
(11, 12, 'Available', 4),
(12, 12, 'Reserved', 6),
(13, 12, 'Available', 1),
(14, 4, 'Reserved', 3),
(15, 4, 'Available', 5),
(16, 4, 'Reserved', 2),
(17, 4, 'Available', 4),
(18, 8, 'Reserved', 6),
(19, 8, 'Available', 1),
(20, 8, 'Reserved', 3),
(21, 8, 'Available', 5),
(22, 12, 'Reserved', 2),
(23, 12, 'Available', 4),
(24, 12, 'Reserved', 6),
(25, 12, 'Available', 1);

-- category(id, name)
INSERT INTO category VALUES
(1, 'Japanese'),
(2, 'Grill'),
(3, 'Soup'),
(4, 'Dessert'),
(5, 'Salad'),
(6, 'Western'),
(7, 'Vietnamese');

-- menu_item(id, name, price, new_item, category_id)
INSERT INTO menu_item VALUES
(1, 'Tuna', 6.00, NULL, 1),
(2, 'Herring', 5.00, NULL, 1),
(3, 'Milk Oyster', 8.00, NULL, 1),
(4, 'Octopus', 6.00, 'YES', 1),
(5, 'Sushi', 5.50, NULL, 1),
(6, 'Beef Steak', 9.50, NULL, 2),
(7, 'Chicken Wings', 8.00, NULL, 2),
(8, 'Sweet Snails', 7.00, 'YES', 2),
(9, 'Roasted Duck', 9.00, 'YES', 2),
(10, 'Chicken Soup', 4.00, NULL, 3),
(11, 'Salmon Soup', 6.50, NULL, 3),
(12, 'Pumpkin Soup', 4.50, 'YES', 3),
(13, 'Ice Cream', 3.00, NULL, 4),
(14, 'Fried Cake', 3.50, 'YES', 4),
(15, 'Yogurt', 2.50, NULL, 4),
(16, 'Coconut Jelly', 3.00, NULL, 4),
(17, 'Fruit Salad', 3.50, NULL, 5),
(18, 'Kimchi', 3.00, NULL, 5),
(19, 'Banana Salad with Jellyfish', 4.50, 'YES', 5),
(20, 'Macaroni', 5.00, NULL, 6),
(21, 'Spaghetti', 6.00, NULL, 6),
(22, 'Baked Shrimp', 9.00, 'YES', 6),
(23, 'Seafood Pizza', 7.50, NULL, 6),
(24, 'Beef Pho', 6.00, NULL, 7),
(25, 'Crab Noodle Soup', 5.00, 'YES', 7),
(26, 'Sticky Rice', 4.50, NULL, 7),
(27, 'Spring Roll', 3.50, NULL, 7);

-- role(id, name, salary)
INSERT INTO role VALUES
(1, 'Chef', 2000.00),
(2, 'Waiter', 1200.00),
(3, 'Manager', 3000.00),
(4, 'Cleaner', 1000.00),
(5, 'Cashier', 1500.00);

-- shift(id, name, start_time, end_time)
INSERT INTO shift VALUES
(1, 'Morning', '08:00', '12:00'),
(2, 'Afternoon', '12:00', '16:00'),
(3, 'Evening', '16:00', '20:00'),
(4, 'Night', '20:00', '00:00'),
(5, 'Full', '08:00', '20:00');

-- employee(id, first_name, last_name, birth_date, phone_number, address, start_date, role_id, branch_id)
INSERT INTO employee VALUES
(1, 'Tran', 'Viet', '1988-04-25', '0918726112', 'Ha Noi', '2023-05-03', 1, 1),
(2, 'Nguyen', 'Duc', '1989-05-09', '0981763223', 'Hai Phong', '2021-04-17', 1, 2),
(3, 'Dao', 'Anh', '1981-07-12', '0918726263', 'Ha Noi', '2021-07-17', 1, 3),
(4, 'Tran', 'Minh', '1985-12-15', '0918723663', 'Da Nang', '2021-04-17', 1, 4),
(5, 'Van', 'Hoa', '1993-08-14', '0912651299', 'Hai Phong', '2024-09-16', 1, 5),
(6, 'Le', 'Trang', '1995-11-11', '0967445176', 'Da Nang', '2023-07-06', 1, 6),
(7, 'Tran', 'Long', '1988-04-21', '0918278238', 'Ha Noi', '2022-04-09', 1, 1),
(8, 'Nguyen', 'Trang', '1989-05-03', '0981761267', 'Hai Phong', '2021-04-02', 1, 2),
(9, 'Dao', 'Hai', '1993-08-19', '0912601293', 'Hai Phong', '2021-05-12', 2, 1),
(10, 'Le', 'Duc', '1995-11-14', '0967445176', 'Da Nang', '2022-03-01', 2, 2),
(11, 'Tran', 'Manh', '1988-04-26', '0918264112', 'Ha Noi', '2021-02-14', 2, 3),
(12, 'Nguyen', 'Binh', '1989-05-12', '0972043223', 'Hai Phong', '2024-01-06', 2, 4),
(13, 'Dao', 'Minh', '1981-07-15', '0918937463', 'Ha Noi', '2022-06-19', 2, 5),
(14, 'Tran', 'Nam', '1985-12-19', '0918276463', 'Da Nang', '2021-06-16', 2, 6),
(15, 'Van', 'Nam', '1993-08-24', '0912194599', 'Hai Phong', '2023-04-08', 2, 1),
(16, 'Le', 'Linh', '1995-11-01', '0967871276', 'Da Nang', '2021-04-02', 2, 2),
(17, 'Tran', 'Khoi', '1988-04-20', '0918726112', 'Ha Noi', '2023-05-12', 2, 3),
(18, 'Nguyen', 'Hien', '1989-05-19', '0981823923', 'Hai Phong', '2025-08-17', 2, 4),
(19, 'Tran', 'Dung', '1985-12-10', '0918274663', 'Da Nang', '2024-08-17', 2, 5),
(20, 'Dao', 'Yen', '1993-08-11', '0912656492', 'Hai Phong', '2024-03-06', 2, 6),
(21, 'Le', 'Binh', '1995-11-17', '0967448713', 'Da Nang', '2020-04-08', 3, 1),
(22, 'Van', 'Dung', '1989-05-04', '0981728323', 'Hai Phong', '2022-05-13', 3, 2),
(23, 'Dao', 'An', '1981-07-11', '0912128263', 'Ha Noi', '2021-04-06', 3, 3),
(24, 'Tran', 'Tuan', '1985-12-05', '0972193663', 'Da Nang', '2023-04-04', 3, 4),
(25, 'Dao', 'Tuan', '1993-08-04', '0912672919', 'Hai Phong', '2021-07-17', 3, 5),
(26, 'Le', 'Long', '1995-11-18', '0967487916', 'Da Nang', '2022-07-04', 3, 6),
(27, 'Van', 'Khai', '1988-04-23', '0918720112', 'Ha Noi', '2023-09-17', 4, 1),
(28, 'Nguyen', 'Thanh', '1989-05-07', '0981810323', 'Hai Phong', '2023-02-18', 4, 2),
(29, 'Tran', 'Phuong', '1985-12-19', '0918810363', 'Da Nang', '2021-12-08', 4, 3),
(30, 'Dao', 'Tien', '1993-08-12', '0912661039', 'Hai Phong', '2022-03-12', 4, 4),
(31, 'Do', 'Yen', '1987-07-10', '0912173913', 'Ha Noi', '2021-03-06', 4, 5),
(32, 'Tran', 'Khoa', '1986-02-05', '0993713663', 'Da Nang', '2023-04-14', 4, 6);

-- ============
-- ADD FUNCTION
-- ============
-- CUSTOMER
CREATE OR REPLACE FUNCTION add_customer(
    p_first_name VARCHAR,
    p_phone_number VARCHAR
)
RETURNS VOID AS $$
DECLARE
    new_id INT;
BEGIN
    SELECT COALESCE(MAX(customer_id), 0) + 1 INTO new_id FROM customer;

    INSERT INTO customer (customer_id, first_name, phone_number)
    VALUES (new_id, p_first_name, p_phone_number);
END;
$$ LANGUAGE plpgsql;

-- EMPLOYEE
CREATE OR REPLACE FUNCTION add_employee(
	p_role_id INT,
	p_branch_id INT,
    p_first_name VARCHAR
)
RETURNS VOID AS $$
DECLARE
	new_employee_id INT;
BEGIN 
	SELECT COALESCE(MAX(employee_id), 0) + 1 INTO new_employee_id FROM employee;

	INSERT INTO employee(employee_id, first_name, role_id, branch_id)
	VALUES (new_employee_id, p_first_name, p_role_id, p_branch_id);
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

	INSERT INTO menu_item(menu_item_id, menu_item_name, price, category_id)
	VALUES (new_menu_item_id, p_menu_item_name, p_price, p_category_id);
END;
$$ LANGUAGE plpgsql;

-- TABLE
CREATE OR REPLACE FUNCTION add_table(
	p_seat_count INT
)
RETURNS VOID AS $$
DECLARE 
	new_table_id INT;
BEGIN
	SELECT COALESCE(MAX(table_id), 0) + 1 INTO new_table_id FROM restaurant_table;

	INSERT INTO restaurant_table(table_id, seat_count, status)
	VALUES (new_table_id, p_seat_count, 'Available');
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

-- ORDER
CREATE OR REPLACE FUNCTION add_order(
    p_reservation_id INT
)
RETURNS VOID AS $$
DECLARE
    new_order_id INT;
BEGIN
	IF (
		SELECT status
		FROM reservation
		WHERE reservation_id = p_reservation_id
	) = 'Active' THEN
	    SELECT COALESCE(MAX(order_id), 0) + 1 INTO new_order_id FROM orders;
	
		INSERT INTO orders(order_id, reservation_id, order_time)
	    VALUES (new_order_id, p_reservation_id, current_time);
	END IF;
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

-- ===============
-- ORTHER FUNCTION
-- ===============
CREATE OR REPLACE FUNCTION find_table()
RETURNS TABLE (
	table_id INT,
	seat_count INT,
	status VARCHAR
) AS $$
BEGIN 
	RETURN QUERY
	SELECT r.table_id, r.seat_count, r.status
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

    INSERT INTO reservation(reservation_id, customer_id, table_id, reserved_date, reserved_time, start_time, end_time, status, total_amount)
    VALUES (new_reservation_id, NULL, NEW.table_id, current_date, current_time, NULL, NULL, 'Pending', 0.00);
	
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

	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER af_add_payment
AFTER INSERT ON payment
FOR EACH ROW 
WHEN (NEW.payment_id IS NOT NULL)
EXECUTE FUNCTION tf_af_add_payment()
