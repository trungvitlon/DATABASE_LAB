CREATE OR REPLACE FUNCTION get_employee_list(p_branch_id INT)
RETURNS TABLE (
	employee_id INT,
	employee_name TEXT,
	phone_number VARCHAR,
	address VARCHAR,
	start_date DATE,
	role_name VARCHAR
) AS $$
BEGIN
	RETURN QUERY
	SELECT 
		e.employee_id, 
		first_name || ' ' || last_name AS employee_name,
		e.phone_number, 
		e.address,
		e.start_date,
		r.role_name
	FROM employee e 
		JOIN role r ON r.role_id = e.role_id
	WHERE e.branch_id = p_branch_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_revenue_by_branch(p_branch_id INT)
RETURNS TABLE (
	branch_id INT,
	manager_name TEXT,
	phone_number VARCHAR,
	address VARCHAR,
	total_revenue NUMERIC
) AS $$
BEGIN
	RETURN QUERY
	SELECT 
		b.branch_id, 
		m.first_name || ' ' || m.last_name AS manager_name,
		b.phone_number, 
		b.address, 
		SUM(final_price) AS total_revenue
	FROM branch b
		JOIN manager m ON m.manager_id = b.manager_id
		JOIN restaurant_table t ON t.branch_id = b.branch_id
		JOIN reservation r ON r.table_id = t.table_id
		JOIN payment p ON p.reservation_id = r.reservation_id
	WHERE r.status = 'Paid'
	AND b.branch_id = p_branch_id
	GROUP BY b.branch_id, m.first_name, m.last_name, b.phone_number, b.address
	ORDER BY b.branch_id ASC;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION add_employee(
    p_first_name VARCHAR,
	p_last_name VARCHAR,
	p_birth_date DATE,
	p_phone_number VARCHAR,
	p_address VARCHAR,
	p_role_id INT,
	p_branch_id INT
)
RETURNS VOID AS $$
DECLARE
	new_employee_id INT;
BEGIN 
	SELECT COALESCE(MAX(employee_id), 0) + 1 INTO new_employee_id FROM employee;

	INSERT INTO employee(employee_id, first_name, last_name, birth_date, phone_number, address, start_date, role_id, branch_id)
	VALUES (new_employee_id, p_first_name, p_last_name, p_birth_date, p_phone_number, p_address, CURRENT_DATE, p_role_id, p_branch_id);
END;
$$ LANGUAGE plpgsql;