DROP DATABASE IF EXISTS DBMS;
CREATE DATABASE IF NOT EXISTS DBMS;
USE DBMS;

-- Question 1






-- Question 2

CREATE TABLE Product (
    BarCode INT PRIMARY KEY,
    PName VARCHAR(255),
    Price DECIMAL(10, 2),
    QuantityInStock INT
);

CREATE TABLE Sale (
    SaleID INT PRIMARY KEY,
    DeliveryAddress VARCHAR(255),
    CreditCard VARCHAR(16)
);

CREATE TABLE SaleItem (
    SaleID INT,
    BarCode INT,
    Quantity INT,
    FOREIGN KEY (SaleID) REFERENCES Sale(SaleID),
    FOREIGN KEY (BarCode) REFERENCES Product(BarCode)
);

DELIMITER //

CREATE TRIGGER updateAvailableQuantity
AFTER INSERT ON SaleItem
FOR EACH ROW
BEGIN
    UPDATE Product
    SET QuantityInStock = QuantityInStock - NEW.Quantity
    WHERE BarCode = NEW.BarCode;
END;
//

DELIMITER ;

INSERT INTO Product (BarCode, PName, Price, QuantityInStock)
VALUES
    (1001, 'Product A', 10.99, 50),
    (1002, 'Product B', 15.49, 70),
    (1003, 'Product C', 8.99, 30),
    (1004, 'Product D', 20.75, 90),
    (1005, 'Product E', 5.25, 60);

INSERT INTO Sale (SaleID, DeliveryAddress, CreditCard)
VALUES
    (1, 'Address 1', '1234-5678-9012'),
    (2, 'Address 2', '9876-5432-1098'),
    (3, 'Address 3', '5678-1234-9012'),
    (4, 'Address 4', '3456-7890-1234'),
    (5, 'Address 5', '7890-2345-6789');

SELECT * FROM Sale;
SELECT * FROM Product;

INSERT INTO SaleItem (SaleID, BarCode, Quantity) VALUES (1, 1001, 2);

SELECT * FROM Product;
SELECT * FROM Sale;



-- Question 3

-- Creating Employee table
CREATE TABLE Employee (
    empNo INT PRIMARY KEY,
    empName VARCHAR(50),
    jobPosition VARCHAR(50),
    managerId INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (managerId) REFERENCES Employee(empNo) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Creating Department table
CREATE TABLE Department (
    departmentNumber INT PRIMARY KEY,
    departmentName VARCHAR(50)
);

-- Creating Company table
CREATE TABLE Company (
    empNo INT,
    departmentNumber INT,
    joiningDate DATE,
    PRIMARY KEY (empNo, departmentNumber),
    FOREIGN KEY (empNo) REFERENCES Employee(empNo) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (departmentNumber) REFERENCES Department(departmentNumber) ON DELETE CASCADE ON UPDATE CASCADE
);
