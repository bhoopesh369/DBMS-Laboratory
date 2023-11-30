DROP DATABASE IF EXISTS DBMS;
CREATE DATABASE IF NOT EXISTS DBMS;
USE DBMS;

-- Question 1

CREATE TABLE AUTHOR (
    author_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE PUBLISHER (
    publisher_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE CATALOGA (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author_id INT,
    publisher_id INT,
    category_id INT,
    year INT,
    price INT,
    FOREIGN KEY (author_id) REFERENCES AUTHOR(author_id),
    FOREIGN KEY (publisher_id) REFERENCES PUBLISHER(publisher_id)
);

CREATE TABLE CATEGORY (
    category_id INT PRIMARY KEY,
    description VARCHAR(50)
);

CREATE TABLE ORDER_DETAILS (
    order_no INT PRIMARY KEY,
    book_id INT,
    quantity INT,
    FOREIGN KEY (book_id) REFERENCES CATALOGA(book_id)
);


INSERT INTO AUTHOR (author_id, name, city, country) VALUES
(1, 'Author1', 'City1', 'Country1'),
(2, 'Author2', 'City2', 'Country2'),
(3, 'Author3', 'City3', 'Country3'),
(4, 'Author4', 'City4', 'Country4'),
(5, 'Author5', 'City5', 'Country5');

INSERT INTO PUBLISHER (publisher_id, name, city, country) VALUES
(1, 'Publisher1', 'City1', 'Country1'),
(2, 'Publisher2', 'City2', 'Country2'),
(3, 'Publisher3', 'City3', 'Country3'),
(4, 'Publisher4', 'City4', 'Country4'),
(5, 'Publisher5', 'City5', 'Country5');

INSERT INTO CATEGORY (category_id, description) VALUES
(1, 'Category1'),
(2, 'Category2'),
(3, 'Category3'),
(4, 'Category4'),
(5, 'Category5');

INSERT INTO CATALOGA (book_id, title, author_id, publisher_id, category_id, year, price) VALUES
(1, 'Title1', 1, 1, 1, 2001, 100),
(2, 'Title2', 2, 2, 2, 2002, 200),
(3, 'Title3', 3, 3, 3, 2003, 300),
(4, 'Title4', 4, 4, 4, 2004, 400),
(5, 'Title5', 5, 5, 5, 2005, 500);

INSERT INTO ORDER_DETAILS (order_no, book_id, quantity) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

SELECT * FROM AUTHOR;

SELECT COUNT(*) AS total_authors FROM AUTHOR;

SELECT book_id, SUM(quantity) AS total_sales
FROM ORDER_DETAILS
GROUP BY book_id
ORDER BY SUM(quantity) DESC
LIMIT 1;

-- Question 2

CREATE TABLE Book (
    Acc_no INT,
    Yr_pub INT,
    title VARCHAR(50)
);

INSERT INTO Book (Acc_no, Yr_pub, title) VALUES
(734216, 1982, 'Algorithm design'),
(237235, 1995, 'Database systems'),
(631523, 1992, 'Compiler design'),
(543211, 1991, 'Programming'),
(376112, 1992, 'Machine design');


SELECT * FROM Book WHERE Yr_pub = 1992;

SELECT * FROM Book WHERE Acc_no > 567842;

SELECT title, Acc_no FROM Book;

SELECT Acc_no AS 'SERIAL NO', Yr_pub AS 'YEAR', title 
FROM Book;

SELECT * FROM Book WHERE title LIKE '%design%';

SELECT * FROM Book WHERE title LIKE '%design%' AND Yr_pub > 1990;

-- Question 3

CREATE TABLE branch (
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_city VARCHAR(50),
    assets DECIMAL(15, 2)
);

CREATE TABLE customer (
    customer_name VARCHAR(50) PRIMARY KEY,
    customer_street VARCHAR(100),
    customer_city VARCHAR(50)
);

CREATE TABLE account (
    account_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    balance DECIMAL(15, 2),
    FOREIGN KEY (branch_name) REFERENCES branch(branch_name)
);

CREATE TABLE loan (
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount DECIMAL(15, 2),
    FOREIGN KEY (branch_name) REFERENCES branch(branch_name)
);

CREATE TABLE depositor (
    customer_name VARCHAR(50),
    account_number INT,
    PRIMARY KEY (customer_name, account_number),
    FOREIGN KEY (customer_name) REFERENCES customer(customer_name),
    FOREIGN KEY (account_number) REFERENCES account(account_number)
);

CREATE TABLE borrower (
    customer_name VARCHAR(50),
    loan_number INT,
    PRIMARY KEY (customer_name, loan_number),
    FOREIGN KEY (customer_name) REFERENCES customer(customer_name),
    FOREIGN KEY (loan_number) REFERENCES loan(loan_number)
);

INSERT INTO branch (branch_name, branch_city, assets) VALUES
('Downtown', 'Brooklyn', 100000),
('Perryridge', 'Redwood', 200000),
('Brighton', 'Brooklyn', 300000),
('Round Hill', 'Harrison', 400000),
('Indain ', 'Brooklyn', 500000);

INSERT INTO customer (customer_name, customer_street, customer_city) VALUES
('Hayes', 'Main', 'Harrison'),
('Jones', 'Main', 'Harrison'),
('Smith', 'Main', 'Harrison'),
('Williams', 'Main', 'Harrison'),
('Brown', 'Main', 'Harrison'),
('Doe', 'Main', 'Harrison'),
('Johnson', 'Main', 'Harrison'),
('Miller', 'Main', 'Harrison'),
('Anderson', 'Main', 'Harrison'),
('Clark', 'Main', 'Harrison');

INSERT INTO account VALUES
(101, 'Downtown', 500),
(102, 'Perryridge', 400),
(103, 'Brighton', 900),
(105, 'Round Hill', 700),
(106, 'Indain', 700);

INSERT INTO loan VALUES
(201, 'Downtown', 900),
(202, 'Perryridge', 900),
(203, 'Brighton', 900),
(205, 'Round Hill', 900),
(206, 'Indain', 900);

INSERT INTO depositor VALUES
('Hayes', 101),
('Jones', 102),
('Smith', 103),
('Williams', 105),
('Brown', 106),
('Doe', 106),
('Johnson', 106),
('Miller', 106),
('Anderson', 106),
('Clark', 106);

INSERT INTO borrower VALUES
('Hayes', 201),
('Jones', 202),
('Smith', 203),
('Williams', 205),
('Brown', 206),
('Doe', 206),
('Johnson', 206),
('Miller', 206),
('Anderson', 206),
('Clark', 206);

SELECT * FROM loan WHERE amount > 120000;

SELECT branch_name FROM branch WHERE branch_city = 'Brooklyn';

SELECT customer_name 
FROM depositor 
WHERE account_number = 101;

SELECT customer_name 
FROM customer 
WHERE customer_name LIKE 'J%';
