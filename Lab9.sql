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
