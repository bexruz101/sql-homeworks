CREATE TABLE student (
    id INTEGER,
    name VARCHAR(100),
    age INTEGER
);

ALTER TABLE student
ALTER COLUMN id INTEGER NOT NULL;

CREATE TABLE product (
    product_id INTEGER UNIQUE,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

ALTER TABLE product
DROP CONSTRAINT IF EXISTS uq_product_id;

ALTER TABLE product
ADD CONSTRAINT uq_product_id_name UNIQUE (product_id, product_name);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE
);

ALTER TABLE orders
DROP CONSTRAINT IF EXISTS pk_orders;

ALTER TABLE orders
ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);

CREATE TABLE category (
    category_id INTEGER PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE item (
    item_id INTEGER PRIMARY KEY,
    item_name VARCHAR(100),
    category_id INTEGER,
    CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES category(category_id)
);

ALTER TABLE item
DROP CONSTRAINT IF EXISTS fk_category_id;

ALTER TABLE item
ADD CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES category(category_id);

CREATE TABLE account (
    account_id INTEGER PRIMARY KEY,
    balance DECIMAL(10, 2) CHECK (balance >= 0),
    account_type VARCHAR(20) CHECK (account_type IN ('Saving', 'Checking'))
);

ALTER TABLE account
DROP CONSTRAINT IF EXISTS chk_balance;

ALTER TABLE account
ADD CONSTRAINT chk_balance CHECK (balance >= 0);

CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100) DEFAULT 'Unknown'
);

ALTER TABLE customer
ALTER COLUMN city SET DEFAULT 'Unknown';

CREATE TABLE invoice (
    invoice_id INTEGER PRIMARY KEY IDENTITY(1,1),
    amount DECIMAL(10, 2)
);

INSERT INTO invoice (amount) VALUES (100.50), (200.75), (300.00), (150.25), (75.80);

SET IDENTITY_INSERT invoice ON;

INSERT INTO invoice (invoice_id, amount) VALUES (100, 500.00);

SET IDENTITY_INSERT invoice OFF;

CREATE TABLE books (
    book_id INTEGER PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(200) NOT NULL,
    price DECIMAL(10, 2) CHECK (price > 0),
    genre VARCHAR(100) DEFAULT 'Unknown'
);

INSERT INTO books (title, price) VALUES
('Book 1', 25.99),
('Book 2', 19.95),
('Book 3', 32.50);

CREATE TABLE Book (
    book_id INTEGER PRIMARY KEY,
    title TEXT,
    author TEXT,
    published_year INTEGER
);

CREATE TABLE Member (
    member_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    phone_number TEXT
);

CREATE TABLE Loan (
    loan_id INTEGER PRIMARY KEY,
    book_id INTEGER,
    member_id INTEGER,
    loan_date DATE,
    return_date DATE,
    CONSTRAINT fk_book_id FOREIGN KEY (book_id) REFERENCES Book(book_id),
    CONSTRAINT fk_member_id FOREIGN KEY (member_id) REFERENCES Member(member_id)
);

INSERT INTO Book (book_id, title, author, published_year) VALUES
(1, 'Book A', 'Author X', 2005),
(2, 'Book B', 'Author Y', 2010),
(3, 'Book C', 'Author Z', 2018);

INSERT INTO Member (member_id, name, email, phone_number) VALUES
(1, 'John Doe', 'john.doe@example.com', '+1234567890'),
(2, 'Jane Smith', 'jane.smith@example.com', '+1987654321');

INSERT INTO Loan (loan_id, book_id, member_id, loan_date, return_date) VALUES
(1, 1, 1, '2025-03-01', NULL),
(2, 2, 1, '2025-03-10', '2025-03-20'),
(3, 3, 2, '2025-04-05', NULL);
