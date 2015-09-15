-- TRUNCATES THE DATABASE.
-- POPULATES THE DATABASE WITH A SET OF VALUES

USE COMM;

DELETE FROM COMM_USER_ROLES;
DELETE FROM COMM_USERS;
DELETE FROM COMM_ROLES;

DELETE FROM COMM_PRODUCT_CATEGORY;
DELETE FROM COMM_PRODUCTS;

INSERT INTO COMM_ROLES (ID, DESCRIPTION) VALUES (1,'Administrator');
INSERT INTO COMM_ROLES (ID, DESCRIPTION) VALUES (2,'Customer');

INSERT INTO COMM_USERS (ID, FULL_NAME, USERNAME, PASSWORD) VALUES (1, 'Henry Smith','hsmith','smith');
INSERT INTO COMM_USERS (ID, FULL_NAME, USERNAME, PASSWORD) VALUES (2, 'Tim Bucktoo','tbucktoo','bucktoo');
INSERT INTO COMM_USERS (ID, FULL_NAME, USERNAME, PASSWORD) VALUES (3, 'Jenny Admin','jadmin','admin');

INSERT INTO COMM_USER_ROLES (USER_ID, ROLE_ID) VALUES (1, 2);
INSERT INTO COMM_USER_ROLES (USER_ID, ROLE_ID) VALUES (2, 2);
INSERT INTO COMM_USER_ROLES (USER_ID, ROLE_ID) VALUES (3, 1);

LOAD DATA LOCAL INFILE 'src/product-dump.csv' INTO TABLE COMM_PRODUCTS
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(ID,ASIN,TITLE,CLASS);

LOAD DATA LOCAL INFILE 'src/category-dump.csv' INTO TABLE COMM_PRODUCT_CATEGORY
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(PRODUCT_ID,CHAIN);

SELECT * FROM COMM_ROLES;
SELECT * FROM COMM_USERS;
SELECT * FROM COMM_USER_ROLES;
SELECT * FROM COMM_PRODUCTS;
SELECT * FROM COMM_PRODUCT_CATEGORY;