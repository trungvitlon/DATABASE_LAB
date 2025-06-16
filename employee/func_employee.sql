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
    UPDATE restaurant_table
    SET status = p_status
    WHERE table_id = p_table_id;
END;
$$ LANGUAGE plpgsql;
