CREATE VIEW view_reservation_history AS
SELECT 
	r.reservation_id, 
	first_name || ' ' || last_name AS customer_name, 
	reserved_date AS date, start_time, 
	final_price
FROM reservation r
	JOIN customer c ON c.customer_id = r.customer_id
	JOIN payment p ON p.reservation_id = r.reservation_id
WHERE status = 'Paid';

CREATE VIEW view_branch_summary AS
SELECT 
	b.branch_id, 
	m.first_name || ' ' || m.last_name AS manager_name,
	b.phone_number, 
	b.address, 
	COUNT(DISTINCT employee_id) AS employee_count,
	COUNT(DISTINCT table_id) AS table_count,
	COUNT(DISTINCT table_id) FILTER (WHERE status = 'Available') AS available,
    COUNT(DISTINCT table_id) FILTER (WHERE status = 'Reserved') AS reserved,
    COUNT(DISTINCT table_id) FILTER (WHERE status = 'Occupied') AS occupied
FROM branch b
	JOIN manager m ON m.manager_id = b.manager_id
	LEFT JOIN employee e ON e.branch_id = b.branch_id
	LEFT JOIN restaurant_table r ON r.branch_id = b.branch_id
GROUP BY b.branch_id, m.first_name, m.last_name, b.phone_number, b.address
ORDER BY b.branch_id ASC;

CREATE VIEW view_table_status_summary AS
SELECT
    COUNT(*) FILTER (WHERE status = 'Available') AS available,
    COUNT(*) FILTER (WHERE status = 'Reserved') AS reserved,
    COUNT(*) FILTER (WHERE status = 'Occupied') AS occupied
FROM restaurant_table;

CREATE VIEW view_revenue_by_day AS
SELECT
	reserved_date AS date,
	SUM(final_price) AS total_revenue
FROM reservation r
	JOIN payment p ON p.reservation_id = r.reservation_id
WHERE status = 'Paid'
GROUP BY reserved_date
ORDER BY reserved_date DESC;

CREATE VIEW view_best_selling_items AS
SELECT 
	m.menu_item_id, 
	menu_item_name, price, 
	SUM(quantity) AS total_sold
FROM order_detail o
	JOIN menu_item m ON m.menu_item_id = o.menu_item_id
GROUP BY m.menu_item_id, menu_item_name, price
ORDER BY total_sold DESC;

CREATE VIEW view_new_items AS
SELECT 
	menu_item_id, 
	menu_item_name, 
	price
FROM menu_item
WHERE new_item = 'YES';

CREATE VIEW view_employee_list AS
SELECT * FROM employee
ORDER BY branch_id ASC;