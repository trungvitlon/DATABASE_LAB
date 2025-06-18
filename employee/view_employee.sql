DROP VIEW IF EXISTS view_active_tables;

CREATE OR REPLACE VIEW view_active_tables AS
SELECT
    rt.table_id,
    rt.seat_count,
    rt.status,
    b.branch_id,
    b.address AS branch_address
FROM restaurant_table rt
JOIN branch b ON rt.branch_id = b.branch_id
WHERE LOWER(rt.status) = 'reserved';
-------------

DROP VIEW IF EXISTS view_reservations_today;
CREATE OR REPLACE VIEW view_reservations_today AS
SELECT
    r.reservation_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    r.reserved_time,
    r.start_time,
    r.end_time,
    rt.table_id,
    rt.status
FROM reservation r
JOIN customer c ON r.customer_id = c.customer_id
JOIN restaurant_table rt ON r.table_id = rt.table_id
WHERE r.reserved_date = CURRENT_DATE;
------------

DROP VIEW IF EXISTS view_order_details;
CREATE OR REPLACE VIEW view_order_details AS
SELECT
    o.order_id,
    mi.menu_item_name,
    od.quantity,
    mi.price,
    (od.quantity * mi.price) AS subtotal
FROM order_detail od
JOIN orders o ON od.order_id = o.order_id
JOIN menu_item mi ON od.menu_item_id = mi.menu_item_id;
----------------

DROP VIEW IF EXISTS view_customer_info_basic;
CREATE OR REPLACE VIEW view_customer_info_basic AS
SELECT
    customer_id,
    first_name || ' ' || last_name AS full_name,
    phone_number,
    address
FROM customer;
----------------

DROP VIEW IF EXISTS view_menu_item_list;
CREATE OR REPLACE VIEW view_menu_item_list AS
SELECT
    mi.menu_item_id,
    mi.menu_item_name,
    mi.price,
    c.category_name,
    mi.new_item
FROM menu_item mi
JOIN category c ON mi.category_id = c.category_id;
----------------

CREATE OR REPLACE VIEW view_pending_payments AS
SELECT
    r.reservation_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    r.total_amount,
    p.payment_id
FROM reservation r
JOIN customer c ON r.customer_id = c.customer_id
LEFT JOIN payment p ON r.reservation_id = p.reservation_id
WHERE p.payment_id IS NULL AND r.total_amount IS NOT NULL;

