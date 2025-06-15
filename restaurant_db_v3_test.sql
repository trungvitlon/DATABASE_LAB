-- ===============
-- SAMPLE FUNCTION
-- ===============
-- add_customer(customer_name, phone_number)
SELECT add_customer('Emma Le', '0933445566');

-- add_order(reservation_id)
SELECT add_order(1);

-- add_order_detail(order_id, menu_item_id, quantity)
SELECT add_order_detail(1, 9, 2);

-- add_payment(reservation_id, payment_method)
SELECT add_payment(1, 'Credit Card');

-- add_table(number_seats)
SELECT add_table(12);

-- add_employee(role_id, employee_name)
SELECT add_employee(1, 'Gordon Ramsey');

-- add_schedule(employee_id, shift_id)
SELECT add_schedule(3, 4);

-- add_category(category_name)
SELECT add_category('Dessert');

-- add_menu_item(category_id, menu_item_name, price)
SELECT add_menu_item(5, 'Black Sticky Rice Yogurt', 3.50);

-- ==============
-- SAMPLE PROCESS
-- ==============
-- Bước 1: Tìm bàn trống
SELECT * FROM find_table();

-- Bước 2: Tạo bàn đặt
-- reserved_table(table_id)
SELECT reserved_table(6);
SELECT * FROM restaurant_table; -- status -> Reserved
SELECT * FROM reservation; -- bàn đặt được thêm vào 

-- Bước 3: Cập nhật bàn đặt khi khách đến
-- update_reseravtion_table(reservation_id, customer_id)
SELECT update_reservation_table(1, 1);
SELECT * FROM reservation;  -- status -> Active -> Có thể gọi mọn 

-- Bước 4: Tạo order 
-- add_order(reservation_id)
SELECT add_order(1);
SELECT * FROM orders; -- order được thêm vào 

-- Bước 5: Xem menu
SELECT * FROM category;
SELECT * FROM menu_item;

-- Bước 6: Thêm món vào order 
-- add_order_detail(order_id, menu_item_id, quantity)
SELECT add_order_detail(1, 4, 2);
SELECT * FROM order_detail; -- order_detail được thêm vào
SELECT * FROM reservation;  -- tổng tiền được cập nhật 

-- Bước 7: Thanh toán 
-- add_payment(reservation_id, payment_method)
SELECT add_payment(1, 'Credit Card');
SELECT * FROM payment; -- payment được thêm vào 
SELECT * FROM reservation;  -- status -> Paid 
SELECT * FROM restaurant_table; -- status -> Available

SELECT * FROM branch;




