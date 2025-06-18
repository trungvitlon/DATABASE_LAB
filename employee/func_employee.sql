CREATE OR REPLACE FUNCTION add_menu_item(
    p_menu_item_id INT,
    p_menu_item_name VARCHAR,
    p_price NUMERIC,
    p_new_item VARCHAR,
    p_category_id INT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO menu_item (menu_item_id, menu_item_name, price, new_item, category_id)
    VALUES (p_menu_item_id, p_menu_item_name, p_price, p_new_item, p_category_id);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_menu_price(
    p_menu_item_id INT,
    p_new_price NUMERIC
) RETURNS VOID AS $$
BEGIN
    UPDATE menu_item
    SET price = p_new_price
    WHERE menu_item_id = p_menu_item_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_average_employee_age()
RETURNS NUMERIC AS $$
DECLARE
    avg_age NUMERIC;
BEGIN
    SELECT AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date)))
    INTO avg_age
    FROM employee
    WHERE birth_date IS NOT NULL;

    RETURN avg_age;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION create_order(
    p_order_id INT,
    p_order_time TIME,
    p_reservation_id INT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO orders (order_id, order_time, reservation_id)
    VALUES (p_order_id, p_order_time, p_reservation_id);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION add_order_detail(
    p_order_detail_id INT,
    p_quantity INT,
    p_menu_item_id INT,
    p_order_id INT
) RETURNS VOID AS $$
BEGIN
    INSERT INTO order_detail (order_detail_id, quantity, menu_item_id, order_id)
    VALUES (p_order_detail_id, p_quantity, p_menu_item_id, p_order_id);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION set_table_status(
    p_table_id INT,
    p_status VARCHAR
) RETURNS VOID AS $$
BEGIN
    -- Cập nhật trạng thái của bàn
    UPDATE restaurant_table
    SET status = p_status
    WHERE table_id = p_table_id;

    -- Cập nhật trạng thái của các reservation có liên quan đến bàn
    UPDATE reservation
    SET status = p_status
    WHERE table_id = p_table_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION process_payment(p_reservation_id INT, p_method VARCHAR)
RETURNS VOID AS $$
DECLARE
    total NUMERIC;
    new_payment_id INT;
BEGIN
    -- Lấy tổng số tiền từ reservation
    SELECT total_amount INTO total
    FROM reservation
    WHERE reservation_id = p_reservation_id;

    -- Sinh payment_id mới = max + 1
    SELECT COALESCE(MAX(payment_id), 0) + 1 INTO new_payment_id
    FROM payment;

    -- Chèn vào bảng payment
    INSERT INTO payment (
        payment_id,
        payment_method,
        final_price,
        reservation_id
    ) VALUES (
        new_payment_id,
        p_method,
        total,
        p_reservation_id
    );
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_customer_reservation_history(p_customer_id INT)
RETURNS TABLE (
    reservation_id INT,
    reserved_date DATE,
    start_time TIME,
    total_amount NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        r.reservation_id,
        r.reserved_date,
        r.start_time,
        r.total_amount
    FROM reservation r
    WHERE r.customer_id = p_customer_id
    ORDER BY r.reserved_date DESC;
END;
$$ LANGUAGE plpgsql;
