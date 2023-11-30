DROP DATABASE IF EXISTS DBMS;
CREATE DATABASE IF NOT EXISTS DBMS;
USE DBMS;


CREATE TABLE employee (
    empno numeric(6) not null primary key,
    ename varchar(20),
    job varchar(10),
    deptno numeric(3),
    sal numeric(7,2)
);

ALTER TABLE employee ADD COLUMN exp numeric(6);


-- INSERT 5 values into the table
INSERT INTO employee 
VALUES 
    (7499,'ALLEN','SALESMAN',30,1600,300),
    (7369,'SMITH','CLERK',20,800,NULL),
    (7521,'WARD','SALESMAN',30,1250,500),
    (7566,'JONES','MANAGER',20,2975,NULL),
    (7654,'MARTIN','SALESMAN',30,1250,1400);

select * from employee;

DROP DATABASE IF EXISTS DBMS;
CREATE DATABASE IF NOT EXISTS DBMS;
USE DBMS;


CREATE TABLE employee (
    empno numeric(6) not null primary key,
    ename varchar(20),
    job varchar(20), 
    deptno numeric(3),
    sal numeric(7,2)
);

ALTER TABLE employee ADD COLUMN exp numeric(6);




INSERT INTO employee 
VALUES 
    (7499,'ALLEN','SALESMAN',30,1600,300),
    (7369,'SMITH','CLERK',20,800,NULL),
    (7521,'WARD','SALESMAN',30,1250,500),
    (7566,'JONES','MANAGER',20,2975,NULL),
    (7654,'MARTIN','SALESMAN',30,1250,1400);

ALTER TABLE employee
MODIFY COLUMN job varchar(10);

TRUNCATE TABLE employee;

CREATE USER 'dbuser'@'localhost' IDENTIFIED BY 'Keeptrying9@';

GRANT ALL PRIVILEGES ON DBMS TO 'dbuser'@'localhost';

GRANT SELECT, ALTER ON DBMS TO 'dbuser'@'localhost';

REVOKE SELECT ON DBMS FROM 'dbuser'@'localhost';
