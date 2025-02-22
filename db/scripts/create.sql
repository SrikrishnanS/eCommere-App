-- CREATES A DATABASE IF IT DOES NOT EXIST.
-- CREATES A NEW SET OF TABLES FOR USERS AND ROLES

CREATE DATABASE IF NOT EXISTS COMM;

USE COMM;

DROP TABLE IF EXISTS COMM_USER_ROLES;
DROP TABLE IF EXISTS COMM_USER_RESPONSES;
DROP TABLE IF EXISTS COMM_USERS;
DROP TABLE IF EXISTS COMM_ROLES;
DROP TABLE IF EXISTS COMM_PRODUCT_REVIEW;
DROP TABLE IF EXISTS COMM_PRODUCT_CATEGORY;
DROP TABLE IF EXISTS COMM_PRODUCT_WAREHOUSE;
DROP TABLE IF EXISTS COMM_PRODUCT_ORDERS;
DROP TABLE IF EXISTS COMM_PRODUCT_BOUGHT;
DROP TABLE IF EXISTS COMM_PRODUCTS;

CREATE TABLE COMM_ROLES (
	ID INT AUTO_INCREMENT NOT NULL,
	DESCRIPTION VARCHAR(50),
	CONSTRAINT PK_ROLE_ID PRIMARY KEY(ID)
);

CREATE TABLE COMM_USERS (
	ID INT AUTO_INCREMENT NOT NULL,
	FULL_NAME VARCHAR(30),
	FIRST_NAME VARCHAR(15)NOT NULL,
	LAST_NAME VARCHAR(15)NOT NULL,
	ADDRESS VARCHAR(50),
	CITY VARCHAR(15),
	STATE VARCHAR(15),
	ZIP VARCHAR(7),
	EMAIL VARCHAR(35),
	USERNAME VARCHAR(30) NOT NULL,
	PASSWORD VARCHAR(30) NOT NULL,

	CONSTRAINT PK_USER_ID PRIMARY KEY (ID),
	CONSTRAINT UQ_USERNAME_PASSWORD UNIQUE(USERNAME,PASSWORD),
	CONSTRAINT UQ_FIRST_LAST_NAME UNIQUE(FIRST_NAME, LAST_NAME)
);

CREATE TABLE COMM_USER_ROLES (
	USER_ID INT NOT NULL,
	ROLE_ID INT NOT NULL,
	CONSTRAINT PK_USER_ROLE_ID PRIMARY KEY(USER_ID, ROLE_ID),
    CONSTRAINT FK_USER_ROLE_USER_ID  FOREIGN KEY (USER_ID) REFERENCES COMM_USERS(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_USER_ROLE_ROLE_ID  FOREIGN KEY (ROLE_ID) REFERENCES COMM_ROLES(ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE COMM_USER_RESPONSES (
	ID INT AUTO_INCREMENT NOT NULL,
	USER_ID INT NOT NULL,
	ANSWER_ONE VARCHAR(4) NOT NULL,
	ANSWER_TWO VARCHAR(4) NOT NULL,
	ANSWER_THREE VARCHAR(4) NOT NULL,
	FEEDBACK_ONE VARCHAR(15) NOT NULL,
	FEEDBACK_TWO VARCHAR(15) NOT NULL,
	FEEDBACK_THREE VARCHAR(15) NOT NULL,
	CONSTRAINT PK_RESPONSE_ID PRIMARY KEY (ID),
	CONSTRAINT FK_USER_RESPONSE_ID  FOREIGN KEY (USER_ID) REFERENCES COMM_USERS(ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE COMM_PRODUCTS (
	ID INT AUTO_INCREMENT NOT NULL,
	ASIN VARCHAR(12) NOT NULL,
	TITLE VARCHAR(80) NOT NULL,
	CLASS VARCHAR(20),	
	SALES_RANK VARCHAR(15),
	SIMILAR VARCHAR(250),
	DOWNLOADED INT,
	AVG_RATING FLOAT(8,2),
	DESCRIPTION VARCHAR(80) NOT NULL,
	CONSTRAINT PK_PRODUCT_ID PRIMARY KEY (ID)
);

CREATE TABLE COMM_PRODUCT_CATEGORY (
	CHAIN_ID INT AUTO_INCREMENT NOT NULL,
	CHAIN VARCHAR(250) NOT NULL,
	PRODUCT_ID INT NOT NULL,
	CONSTRAINT PK_CHAIN_ID PRIMARY KEY (CHAIN_ID),
	CONSTRAINT FK_PRODUCT_ID FOREIGN KEY(PRODUCT_ID) REFERENCES COMM_PRODUCTS(ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE COMM_PRODUCT_WAREHOUSE (
	ID INT NOT NULL,
	QUANTITY_REM INT NOT NULL DEFAULT 5,
	CONSTRAINT PK_PRODUCT_WAREHOUSE_ID PRIMARY KEY (ID),
	CONSTRAINT FK_PRODUCT_WAREHOUSE_ID FOREIGN KEY(ID) REFERENCES COMM_PRODUCTS(ID)	ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE COMM_PRODUCT_ORDERS (
	ID INT NOT NULL,
	QUANTITY_SOLD INT NOT NULL DEFAULT 0,
	CONSTRAINT PK_ORDER_PRODUCT_ID PRIMARY KEY (ID),
	CONSTRAINT FK_ORDER_PRODUCT_ID FOREIGN KEY(ID) REFERENCES COMM_PRODUCTS(ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE COMM_PRODUCT_REVIEW (
	ID INT AUTO_INCREMENT NOT NULL,
	PRODUCT_ID INT NOT NULL,
	POSTED_DATE DATE,
	CUSTOMER VARCHAR(15),
	RATING INT,
	VOTES INT,
	HELPFUL INT,
	CONSTRAINT PK_REVIEW_ID PRIMARY KEY (ID),
	CONSTRAINT FK_REVIEW_PRODUCT_ID FOREIGN KEY(PRODUCT_ID) REFERENCES COMM_PRODUCTS(ID)
);

CREATE TABLE COMM_PRODUCT_BOUGHT (
	ID INT AUTO_INCREMENT NOT NULL,
	PRODUCT_1_ID INT NOT NULL,
	PRODUCT_2_ID INT NOT NULL,
	CONSTRAINT UQ_PRODUCT_ID UNIQUE(PRODUCT_1_ID,PRODUCT_2_ID),
	CONSTRAINT PK_BOUGHT_ID PRIMARY KEY (ID)
);

DESC COMM_ROLES;
DESC COMM_USERS;
DESC COMM_USER_ROLES;
DESC COMM_USER_RESPONSES;
DESC COMM_PRODUCTS;
DESC COMM_PRODUCT_CATEGORY;
DESC COMM_PRODUCT_WAREHOUSE;
DESC COMM_PRODUCT_ORDERS;
DESC COMM_PRODUCT_REVIEW;
DESC COMM_PRODUCT_BOUGHT;