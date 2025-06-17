SELECT add_menu_item(28, 'Pizza Margherita', 150.00, 'yes', 1);
SELECT update_menu_price(3, 175.00);
SELECT create_order(101, CURRENT_TIME::TIME, 5);
SELECT add_order_detail(1001, 2, 3, 101);
SELECT set_table_status(6, 'occupied');
SELECT get_average_employee_age();
SELECT process_payment(5, 'Cash');
SELECT * FROM get_customer_reservation_history(1);
