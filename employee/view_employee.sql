DROP VIEW IF EXISTS view_branch_summary;

CREATE VIEW view_branch_summary AS
SELECT
    b.branch_id,
    b.address,
    COUNT(DISTINCT rt.table_id) AS total_tables,
    COUNT(DISTINCT e.employee_id) AS total_employees,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM branch b
LEFT JOIN restaurant_table rt ON b.branch_id = rt.branch_id
LEFT JOIN employee e ON b.branch_id = e.branch_id
LEFT JOIN reservation r ON rt.table_id = r.table_id
LEFT JOIN orders o ON r.reservation_id = o.reservation_id
GROUP BY b.branch_id, b.address;
----------

DROP VIEW IF EXISTS view_employee_list;
CREATE OR REPLACE VIEW view_employee_list AS
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.start_date,
    r.role_name,
    b.branch_id,
    b.address AS branch_address
FROM employee e
JOIN role r ON e.role_id = r.role_id
JOIN branch b ON e.branch_id = b.branch_id
ORDER BY b.branch_id, r.role_name, e.start_date;
----------

DROP VIEW IF EXISTS view_revenue_by_day;
CREATE OR REPLACE VIEW view_revenue_by_day AS
SELECT
    r.reserved_date,
    SUM(p.final_price) AS total_revenue
FROM reservation r
JOIN payment p ON r.reservation_id = p.reservation_id
GROUP BY r.reserved_date
ORDER BY r.reserved_date;
-----------


DROP VIEW IF EXISTS view_best_selling_items;

CREATE OR REPLACE VIEW view_best_selling_items AS
SELECT
    mi.menu_item_id,
    mi.menu_item_name,
    SUM(od.quantity) AS total_quantity_sold
FROM menu_item mi
JOIN order_detail od ON mi.menu_item_id = od.menu_item_id
GROUP BY mi.menu_item_id, mi.menu_item_name
ORDER BY total_quantity_sold DESC;
----------

DROP VIEW IF EXISTS view_table_status_summary;

CREATE OR REPLACE VIEW view_table_status_summary AS
SELECT
    status,
    COUNT(*) AS total_tables
FROM restaurant_table
GROUP BY status;
----------

DROP VIEW IF EXISTS view_reservation_history;

CREATE OR REPLACE VIEW view_reservation_history AS
SELECT
    r.reservation_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    r.reserved_date,
    r.reserved_time,
    r.start_time,
    r.end_time,
    r.status AS reservation_status,
    p.final_price
FROM reservation r
JOIN customer c ON r.customer_id = c.customer_id
LEFT JOIN payment p ON r.reservation_id = p.reservation_id
ORDER BY r.reserved_date DESC, r.reserved_time DESC;



