CREATE DATABASE IF NOT EXISTS BookStoreDB;
USE BookStoreDB;

CREATE TABLE IF NOT EXISTS Category (
	category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
	`description` VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS Book (
	book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
	`status` INT DEFAULT 1,
    publish_date DATE,
    price DECIMAL(15,2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);
CREATE TABLE IF NOT EXISTS BookOrder (
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
	order_date DATE DEFAULT (CURRENT_DATE),
    delivery_date DATE,
    book_id INT,
    FOREIGN KEY (book_id) REFERENCES Book(book_id) ON DELETE CASCADE
);

ALTER TABLE Book
ADD COLUMN author_name VARCHAR(100) NOT NULL;
ALTER TABLE BookOrder
MODIFY customer_name VARCHAR(200) NOT NULL;
ALTER TABLE BookOrder
ADD CHECK(delivery_date >= order_date);

INSERT INTO Category(category_name, `description`) VALUES
('IT & Tech', 'Sách lập trình'),
('Business', 'Sách kinh doanh'),
('Novel', 'Tiểu thuyết');
INSERT INTO Book(title, `status`, publish_date, price, category_id, author_name) VALUES
('Clean Code', 1, '2020-05-10', 500000, 1, 'Robert C. Martin'),
('Đắc Nhân Tâm', 0, '2018-08-20', 150000, 2, 'Dale Carnegie'),
('JavaScript Nâng cao', 1, '2023-01-15', 350000, 1, 'Kyle Simpson'),
('Nhà Giả Kim', 0, '2015-11-25', 120000, 3, 'Paulo Coelho');
INSERT INTO BookOrder VALUES
(101, 'Nguyen Hai Nam', '2025-01-10', '2025-01-15', 1),
(102, 'Tran Bao Ngoc', '2025-02-05', '2025-02-10', 3),
(103, 'Le Hoang Yen', '2025-03-12', NULL, 4);

UPDATE Book 
SET price = price + 50000
WHERE category_id = 1;
UPDATE BookOrder 
SET delivery_date = '2025-12-31'
WHERE delivery_date IS NULL;
DELETE FROM BookOrder
WHERE order_date < '2025-02-01';

SELECT title, author_name,
	CASE `status`
		WHEN 1 THEN 'Còn hàng'
        WHEN 0 THEN 'Hết hàng'
        ELSE 'Không xác định trạng thái'
	END AS status_name 
FROM Book;
