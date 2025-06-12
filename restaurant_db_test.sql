SELECT * FROM find_table();

SELECT reserved_table(4);

SELECT add_customer('Emma Le', '0933445566');

SELECT * FROM customer;

SELECT update_reservation_table(2, 2);
SELECT * FROM reservation;

SELECT add_order(1);
SELECT o.*, status FROM orders o JOIN reservation r ON r.reservation_id = o.reservation_id;

SELECT * FROM menu_item;
SELECT * FROM category;
SELECT * FROM filter_menu_item(2);
SELECT add_order_detail(3, 9, 2);
SELECT * FROM view_order(1);
SELECT * FROM order_detail;
INSERT INTO order_detail VALUES (4, 5, 9, 2);

SELECT add_payment(1, 'Credit Card');
SELECT * FROM payment;

SELECT add_table(12);
SELECT * FROM restaurant_table
ORDER BY table_id ASC;

SELECT add_employee(3, 'Cam Duong');
SELECT * FROM employee;

SELECT add_schedule(3, 4);
SELECT * FROM schedule_daily;

SELECT add_category('Dessert');
SELECT add_menu_item(8, 'Black Sticky Rice Yogurt', 3.50);

SELECT free_table(1);

SELECT * FROM role;
SELECT * FROM shift;

-- ================
-- REMOVE FUNCTION
-- ================
SELECT remove_orders(1);

SELECT remove_order_detail(1);

SELECT remove_reservation(1);

SELECT remove_payment(1);

SELECT remove_customer(1);

SELECT remove_employee(3);

SELECT remove_category(5);

SELECT remove_menu_item(5);

SELECT remove_table(1);

SELECT remove_schedule(1);