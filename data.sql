-- ===========
-- SAMPLE DATA 
-- ===========
-- customer(id, first_name, last_name, birth_date, phone_number, address)
INSERT INTO customer VALUES
(1, 'Tran', 'Viet', '1988-04-25', '0918726112', 'Ha Noi'),
(2, 'Nguyen', 'Duc', '1989-05-09', '0981763223', 'Hai Phong'),
(3, 'Dao', 'Anh', '1981-07-12', '0918726263', 'Ha Noi'),
(4, 'Tran', 'Minh', '1985-12-15', '0918723663', 'Da Nang'),
(5, 'Dao', 'Hoa', '1993-08-14', '0912651299', 'Hai Phong'),
(6, 'Le', 'Trang', '1995-11-11', '0967445176', 'Da Nang'),
(7, 'Nguyen', 'Hang', '1997-06-16', '0991271016', 'Hai Phong');

-- manager(id, first_name, last_name, birth_date, phone_number, address, start_date)
INSERT INTO manager VALUES
(1, 'Nguyen', 'Linh', '1981-10-20', '0918719212', 'Ha Noi', '2019-04-05'),
(2, 'Ho', 'Thuy', '1983-04-05', '0981782003', 'Hai Phong', '2020-07-17'),
(3, 'Hoang', 'Trung', '1982-03-14', '0918720163', 'Da Nang', '2021-01-13');

-- branch(id, phone_number, address, start_date, manager_id)
INSERT INTO branch VALUES 
(1, '0900447618', 'Ha Noi', '2019-05-21', 1),
(2, '0900441743', 'Hai Phong', '2018-02-01', 2),
(3, '0900441762', 'Da Nang', '2020-08-24', 3),
(4, '0900448712', 'Ha Noi', '2020-07-23', 1),
(5, '0900448712', 'Hai Phong', '2017-07-17', 2),
(6, '0900441264', 'Da Nang', '2022-03-15', 3);

-- table(id, seat_count, status, branch_id)
INSERT INTO restaurant_table VALUES
(1, 4, 'Available', 1),
(2, 4, 'Reserved', 3),
(3, 4, 'Available', 5),
(4, 4, 'Reserved', 2),
(5, 4, 'Available', 4),
(6, 8, 'Available', 6),
(7, 8, 'Available', 1),
(8, 8, 'Available', 3),
(9, 8, 'Available', 5),
(10, 12, 'Reserved', 2),
(11, 12, 'Available', 4),
(12, 12, 'Reserved', 6),
(13, 12, 'Available', 1),
(14, 4, 'Reserved', 3),
(15, 4, 'Available', 5),
(16, 4, 'Reserved', 2),
(17, 4, 'Available', 4),
(18, 8, 'Reserved', 6),
(19, 8, 'Available', 1),
(20, 8, 'Reserved', 3),
(21, 8, 'Available', 5),
(22, 12, 'Reserved', 2),
(23, 12, 'Available', 4),
(24, 12, 'Reserved', 6),
(25, 12, 'Available', 1);

-- category(id, name)
INSERT INTO category VALUES
(1, 'Japanese'),
(2, 'Grill'),
(3, 'Soup'),
(4, 'Dessert'),
(5, 'Salad'),
(6, 'Western'),
(7, 'Vietnamese');

-- menu_item(id, name, price, new_item, category_id)
INSERT INTO menu_item VALUES
(1, 'Tuna', 6.00, NULL, 1),
(2, 'Herring', 5.00, NULL, 1),
(3, 'Milk Oyster', 8.00, NULL, 1),
(4, 'Octopus', 6.00, 'YES', 1),
(5, 'Sushi', 5.50, NULL, 1),
(6, 'Beef Steak', 9.50, NULL, 2),
(7, 'Chicken Wings', 8.00, NULL, 2),
(8, 'Sweet Snails', 7.00, 'YES', 2),
(9, 'Roasted Duck', 9.00, 'YES', 2),
(10, 'Chicken Soup', 4.00, NULL, 3),
(11, 'Salmon Soup', 6.50, NULL, 3),
(12, 'Pumpkin Soup', 4.50, 'YES', 3),
(13, 'Ice Cream', 3.00, NULL, 4),
(14, 'Fried Cake', 3.50, 'YES', 4),
(15, 'Yogurt', 2.50, NULL, 4),
(16, 'Coconut Jelly', 3.00, NULL, 4),
(17, 'Fruit Salad', 3.50, NULL, 5),
(18, 'Kimchi', 3.00, NULL, 5),
(19, 'Banana Salad with Jellyfish', 4.50, 'YES', 5),
(20, 'Macaroni', 5.00, NULL, 6),
(21, 'Spaghetti', 6.00, NULL, 6),
(22, 'Baked Shrimp', 9.00, 'YES', 6),
(23, 'Seafood Pizza', 7.50, NULL, 6),
(24, 'Beef Pho', 6.00, NULL, 7),
(25, 'Crab Noodle Soup', 5.00, 'YES', 7),
(26, 'Sticky Rice', 4.50, NULL, 7),
(27, 'Spring Roll', 3.50, NULL, 7);

-- role(id, name, salary)
INSERT INTO role VALUES
(1, 'Chef', 2000.00),
(2, 'Waiter', 1200.00),
(3, 'Manager', 3000.00),
(4, 'Cleaner', 1000.00),
(5, 'Cashier', 1500.00);

-- employee(id, first_name, last_name, birth_date, phone_number, address, start_date, role_id, branch_id)
INSERT INTO employee VALUES
(1, 'Tran', 'Viet', '1988-04-25', '0918726112', 'Ha Noi', '2023-05-03', 1, 1),
(2, 'Nguyen', 'Duc', '1989-05-09', '0981763223', 'Hai Phong', '2021-04-17', 1, 2),
(3, 'Dao', 'Anh', '1985-07-12', '0918726263', 'Ha Noi', '2021-07-17', 1, 3),
(4, 'Tran', 'Minh', '1985-12-15', '0918723663', 'Da Nang', '2021-04-17', 1, 4),
(5, 'Van', 'Hoa', '1993-08-14', '0912651299', 'Hai Phong', '2024-09-16', 1, 5),
(6, 'Le', 'Trang', '1995-11-11', '0967445176', 'Da Nang', '2023-07-06', 1, 6),
(7, 'Tran', 'Long', '1998-04-21', '0918278238', 'Ha Noi', '2022-04-09', 1, 1),
(8, 'Nguyen', 'Trang', '1989-05-03', '0981761267', 'Hai Phong', '2021-04-02', 1, 2),
(9, 'Dao', 'Hai', '1993-08-19', '0912601293', 'Hai Phong', '2021-05-12', 2, 1),
(10, 'Le', 'Duc', '1995-11-14', '0967445176', 'Da Nang', '2022-03-01', 2, 2),
(11, 'Tran', 'Manh', '1998-04-26', '0918264112', 'Ha Noi', '2021-02-14', 2, 3),
(12, 'Nguyen', 'Binh', '1989-05-12', '0972043223', 'Hai Phong', '2024-01-06', 2, 4),
(13, 'Dao', 'Minh', '1981-07-15', '0918937463', 'Ha Noi', '2022-06-19', 2, 5),
(14, 'Tran', 'Nam', '1987-12-19', '0918276463', 'Da Nang', '2021-06-16', 2, 6),
(15, 'Van', 'Nam', '1993-08-24', '0912194599', 'Hai Phong', '2023-04-08', 2, 1),
(16, 'Le', 'Linh', '1995-11-01', '0967871276', 'Da Nang', '2021-04-02', 2, 2),
(17, 'Tran', 'Khoi', '1992-04-20', '0918726112', 'Ha Noi', '2023-05-12', 2, 3),
(18, 'Nguyen', 'Hien', '1989-05-19', '0981823923', 'Hai Phong', '2025-08-17', 2, 4),
(19, 'Tran', 'Dung', '1985-12-10', '0918274663', 'Da Nang', '2024-08-17', 2, 5),
(20, 'Dao', 'Yen', '1993-08-11', '0912656492', 'Hai Phong', '2024-03-06', 2, 6),
(21, 'Le', 'Binh', '1995-11-17', '0967448713', 'Da Nang', '2020-04-08', 3, 1),
(22, 'Van', 'Dung', '1989-05-04', '0981728323', 'Hai Phong', '2022-05-13', 3, 2),
(23, 'Dao', 'An', '1991-07-11', '0912128263', 'Ha Noi', '2021-04-06', 3, 3),
(24, 'Tran', 'Tuan', '1990-12-05', '0972193663', 'Da Nang', '2023-04-04', 3, 4),
(25, 'Dao', 'Tuan', '1993-08-04', '0912672919', 'Hai Phong', '2021-07-17', 3, 5),
(26, 'Le', 'Long', '1995-11-18', '0967487916', 'Da Nang', '2022-07-04', 3, 6),
(27, 'Van', 'Khai', '1994-04-23', '0918720112', 'Ha Noi', '2023-09-17', 4, 1),
(28, 'Nguyen', 'Thanh', '1989-05-07', '0981810323', 'Hai Phong', '2023-02-18', 4, 2),
(29, 'Tran', 'Phuong', '1993-12-19', '0918810363', 'Da Nang', '2021-12-08', 4, 3),
(30, 'Dao', 'Tien', '1993-08-12', '0912661039', 'Hai Phong', '2022-03-12', 4, 4),
(31, 'Do', 'Yen', '1997-07-10', '0912173913', 'Ha Noi', '2021-03-06', 4, 5),
(32, 'Tran', 'Khoa', '1996-02-05', '0993713663', 'Da Nang', '2023-04-14', 4, 6);