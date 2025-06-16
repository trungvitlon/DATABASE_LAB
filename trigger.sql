-- =======
-- TRIGGER
-- =======
-- UPDATE TABLE ON RESERVATION 
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

CREATE TRIGGER trg_update_table_on_reservation
AFTER UPDATE on restaurant_table
FOR EACH ROW
WHEN (NEW.status = 'Reserved')
EXECUTE FUNCTION add_reservation();

-- UPDATE TABLE ON CHECKOUT
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

CREATE TRIGGER trg_update_table_on_checkout
AFTER INSERT ON payment
FOR EACH ROW 
WHEN (NEW.payment_id IS NOT NULL)
EXECUTE FUNCTION tf_af_add_payment()

-- UPDATE RESERVATION TOTAL AMOUNT
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

CREATE TRIGGER trg_update_reservation_total
AFTER INSERT on order_detail 
FOR EACH ROW
WHEN (NEW.order_detail_id IS NOT NULL)
EXECUTE FUNCTION update_reservation();