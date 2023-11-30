DROP DATABASE IF EXISTS DBMS;
CREATE DATABASE IF NOT EXISTS DBMS;
USE DBMS;

-- Question 1

CREATE TABLE EMP (
    EMPNO INT(6),
    ENAME VARCHAR(20),
    JOB VARCHAR(10),
    DEPT VARCHAR(10),
    DEPTNO INT(3),
    SAL DECIMAL(7,2)
);

-- SET autocommit = 0;

-- Starting a new transaction
START TRANSACTION;

-- Updating an attribute (for example)
UPDATE EMP SET SAL = 5000.00 WHERE EMPNO = 101;

-- Committing the transaction to make the change permanent
COMMIT;

-- Starting a new transaction
START TRANSACTION;

-- Updating an attribute (for example)
UPDATE EMP SET SAL = 5500.00 WHERE EMPNO = 101;

-- Rolling back the transaction to cancel the changes
ROLLBACK;



DELIMITER //

CREATE TRIGGER updateAvailableQuantity AFTER INSERT ON SaleItem
FOR EACH ROW
BEGIN
    UPDATE Product
    SET QuantityInStock = QuantityInStock - NEW.Quantity
    WHERE BarCode = NEW.BarCode;
END;

DELIMITER //;


DELIMITER //

CREATE PROCEDURE spInsertProduct(
    IN p_BarCode INT,
    IN p_PName VARCHAR(50),
    IN p_Price DECIMAL(10,2),
    IN p_QuantityInStock INT
)
BEGIN
    IF p_Price > 0 AND p_QuantityInStock >= 0 THEN
        INSERT INTO Product (BarCode, PName, Price, QuantityInStock)
        VALUES (p_BarCode, p_PName, p_Price, p_QuantityInStock);
    END IF;
END;
//
DELIMITER ;


DELIMITER // 

CREATE FUNCTION spreturn(p_Quantity INT, p_BarCode INT) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total_price DECIMAL(10,2);
    SELECT Price * p_Quantity INTO total_price
    FROM Product
    WHERE BarCode = p_BarCode;
    
    RETURN total_price;
END;

DELIMITER;
