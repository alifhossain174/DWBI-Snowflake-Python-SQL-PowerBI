-- create database test_db;
-- create schema test_db_Schema;

-- Dimension Table: DimDate
CREATE TABLE DimDate (
    DateID INT PRIMARY KEY,
    Date DATE,
    DayOfWeek VARCHAR(10),
    Month VARCHAR(10),
    Quarter INT,
    Year INT,
    IsWeekend BOOLEAN
);

-- Dimension Table: DimCustomer
CREATE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY autoincrement start 1 increment 1,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    DateOfBirth DATE,
    Email VARCHAR(100),
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Country VARCHAR(50),
    LoyaltyProgramID INT
);

-- Dimension Table: DimProduct
CREATE TABLE DimProduct (
    ProductID INT PRIMARY KEY autoincrement start 1 increment 1,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Brand VARCHAR(50),
    UnitPrice DECIMAL(10, 2)
);

-- Dimension Table: DimStore
CREATE TABLE DimStore (
    StoreID INT PRIMARY KEY autoincrement start 1 increment 1,
    StoreName VARCHAR(100),
    StoreType VARCHAR(50),
	StoreOpeningDate DATE,
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    Country VARCHAR(50),
    ManagerName VARCHAR(100)
);

-- Dimension Table: DimLoyaltyProgram
CREATE TABLE DimLoyaltyProgram (
    LoyaltyProgramID INT PRIMARY KEY,
    ProgramName VARCHAR(100),
    ProgramTier VARCHAR(50),
    PointsAccrued INT
);

-- Fact Table: FactOrders
CREATE TABLE FactOrders (
    OrderID INT PRIMARY KEY autoincrement start 1 increment 1,
    DateID INT,
    CustomerID INT,
    ProductID INT,
    StoreID INT,
    QuantityOrdered INT,
    OrderAmount DECIMAL(10, 2),
    DiscountAmount DECIMAL(10, 2),
    ShippingCost DECIMAL(10, 2),
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (DateID) REFERENCES DimDate(DateID),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID),
    FOREIGN KEY (StoreID) REFERENCES DimStore(StoreID)
);


-- file format for csv files
-- CREATE OR REPLACE FILE FORMAT CSV_SOURCE_FILE_FORMAT
-- TYPE='CSV'
-- SKIP_HEADER = 1
-- FIELD_OPTIONALLY_ENCLOSED_BY = '"'
-- DATE_FORMAT = 'YYYY-MM-DD'

-- stage for csv files
-- CREATE or replace STAGE TESTSTAGE

-- file upload commands
-- PUT 'file://D:/DWBI-Snowflake-Python-SQL-PowerBI/One Time Load/DimLoyalty/DimLoyaltyInfo.csv' @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/DimLoyaltyInfo/Auto_Compress=FALSE;
-- PUT 'file://D:/DWBI-Snowflake-Python-SQL-PowerBI/One Time Load/DimCustomer/DimCustomerData.csv' @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/DimCustomerData/Auto_Compress=FALSE;
-- PUT 'file://D:/DWBI-Snowflake-Python-SQL-PowerBI/One Time Load/DimProduct/DimProductData.csv' @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/DimProductData/Auto_Compress=FALSE;
-- PUT 'file://D:/DWBI-Snowflake-Python-SQL-PowerBI/One Time Load/DimDate/DimDate.csv' @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/DimDate/Auto_Compress=FALSE;
-- PUT 'file://D:/DWBI-Snowflake-Python-SQL-PowerBI/One Time Load/DimStore/DimStoreData.csv' @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/DimStoreData/Auto_Compress=FALSE;
-- PUT 'file://D:/DWBI-Snowflake-Python-SQL-PowerBI/Python Files/factorders.csv' @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/factorders/Auto_Compress=FALSE;  
-- PUT 'file://D:/DWBI-Snowflake-Python-SQL-PowerBI/Landing Directory/*.csv' @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/LandingDirectory/Auto_Compress=FALSE; 


-- copy files into databse
COPY INTO DimLoyaltyProgram
FROM @TEST_DB.TEST_DB_SCHEMA.TESTSTAGE/DimLoyaltyInfo/DimLoyaltyInfo.csv
FILE_FORMAT = (FORMAT_NAME = 'CSV_SOURCE_FILE_FORMAT')