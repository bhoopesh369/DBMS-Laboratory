DROP DATABASE IF EXISTS DBMS;
CREATE DATABASE IF NOT EXISTS DBMS;
USE DBMS;

CREATE TABLE IF NOT EXISTS STUDENT (
    RollNumber INT,
    Name VARCHAR(255),
    Address VARCHAR(255),
    Phone NUMERIC(20),
    Age INT,
    PRIMARY KEY (RollNumber)
);

CREATE TABLE IF NOT EXISTS StudentCourse (
    CourseId INT,
    RollNumber INT,
    PRIMARY KEY (CourseId, RollNumber),
    FOREIGN KEY (RollNumber) REFERENCES STUDENT(RollNumber)
);

INSERT INTO STUDENT (RollNumber, Name, Address, Phone, Age) VALUES
(1, 'John Doe', '123 Main St', 1234567890, 20),
(2, 'Jane Smith', '456 Elm St', 9876543210, 22),
(3, 'Mike Johnson', '789 Oak St', 5555555555, 21),
(4, 'Emily Davis', '321 Pine St', 1111111111, 19),
(5, 'EVR Das', 'DAS AND CO HYD', 987974784, 19);

INSERT INTO StudentCourse (CourseId, RollNumber) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4);


SELECT * FROM STUDENT INNER JOIN StudentCourse ON STUDENT.RollNumber = StudentCourse.RollNumber;

SELECT * FROM STUDENT LEFT JOIN StudentCourse ON STUDENT.RollNumber = StudentCourse.RollNumber;

SELECT * FROM STUDENT RIGHT JOIN StudentCourse ON STUDENT.RollNumber = StudentCourse.RollNumber;

SELECT * FROM STUDENT FULL JOIN StudentCourse;

SELECT * FROM STUDENT NATURAL JOIN StudentCourse;

SELECT * FROM STUDENT, StudentCourse WHERE STUDENT.RollNumber = StudentCourse.RollNumber;

SELECT * FROM STUDENT EQUI JOIN StudentCourse;



-- Question 2

-- Create Customer table
CREATE TABLE Customer (
    Cust_id INTEGER PRIMARY KEY,
    cust_name VARCHAR(50)
);

-- Create Item table
CREATE TABLE Item (
    item_id INTEGER PRIMARY KEY,
    item_name VARCHAR(50),
    price INTEGER
);

-- Create Sale table
CREATE TABLE Sale (
    bill_no INTEGER PRIMARY KEY,
    bill_date DATE,
    cust_id INTEGER,
    item_id INTEGER,
    qty_sold INTEGER,
    FOREIGN KEY (cust_id) REFERENCES Customer(Cust_id),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);


INSERT INTO Customer (Cust_id, cust_name) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Mike Johnson'),
(4, 'Emily Davis'),
(5, 'EVR Das');

INSERT INTO Item (item_id, item_name, price) VALUES
(1, 'Item 1', 100),
(2, 'Item 2', 200),
(3, 'Item 3', 300),
(4, 'Item 4', 400),
(5, 'Item 5', 500);

INSERT INTO Sale (bill_no, bill_date, cust_id, item_id, qty_sold) VALUES
(1, '2021-01-01', 1, 1, 1),
(2, '2021-01-02', 2, 2, 2),
(3, '2021-01-03', 3, 3, 3),
(4, '2021-01-04', 4, 4, 4),
(5, '2021-01-05', 5, 5, 5);

CREATE VIEW BILLINFORMATION AS
SELECT bill_no, bill_date, item_name, qty_sold, price, qty_sold * price AS total
FROM Sale s, Item i
WHERE s.item_id = i.item_id;

SELECT * FROM BILLINFORMATION;

CREATE VIEW DATESVIEW AS
SELECT bill_date, SUM(total) AS Total
FROM BILLINFORMATION
WHERE bill_date BETWEEN '2021-01-01' AND '2021-01-05'
GROUP BY bill_date;

SELECT * FROM DATESVIEW;

CREATE VIEW TOP5PRODUCTS AS
SELECT I.item_id, SUM(qty_sold * price) AS Total
FROM Sale s, Item I
GROUP BY item_id
ORDER BY Total DESC
LIMIT 5;

SELECT * FROM TOP5PRODUCTS;


CREATE VIEW TOP5CUSTOMERS AS
SELECT S.cust_id, SUM(I.price * S.qty_sold) as Spending
FROM Sale S
INNER JOIN Item I
WHERE S.item_id = I.item_id AND S.bill_date BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY S.cust_id
ORDER BY Spending DESC
LIMIT 5;

SELECT * FROM TOP5CUSTOMERS;


CREATE VIEW CustomerGroups AS
SELECT cust_id,
    CASE
        WHEN SUM(price * qty_sold) <= 1000 THEN 'SILVER'
        WHEN SUM(price * qty_sold) >= 1000 AND SUM(price * qty_sold) < 5000 THEN 'GOLD'
        WHEN SUM(price * qty_sold) >= 5000 THEN 'PLATINUM'
        ELSE 'NONE'
    END AS customer_group
FROM Sale
INNER JOIN Item
WHERE YEAR(bill_date) = 2021
GROUP BY cust_id;

SELECT * FROM CustomerGroups;
