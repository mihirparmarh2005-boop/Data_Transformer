create database Data_Transformer;
use Data_Transformer;

create table Customers_table(
CustomerID int primary key,
FirstName varchar(100) not null,
LastName varchar(100) not null,
Email varchar(100) not null,
RegistrationDate date
);

insert into Customers_table values
(101, 'Rahul', 'Sharma', 'rahul.sharma@gmail.com', '2025-01-15'),
(102, 'Priya', 'Patel', 'priya.patel@gmail.com', '2025-02-20'),
(103, 'Amit', 'Kumar', 'amit.kumar@gmail.com', '2025-03-10'),
(104, 'Neha', 'Mehta', 'neha.mehta@gmail.com', '2025-04-05'),
(105, 'Rohan', 'Shah', 'rohan.shah@gmail.com', '2025-05-12'),
(106, 'Pooja', 'Joshi', 'pooja.joshi@gmail.com', '2025-06-18'),
(107, 'Vikas', 'Desai', 'vikas.desai@gmail.com', '2025-07-22'),
(108, 'Anjali', 'Patel', 'anjali.patel@gmail.com', '2025-08-08'),
(109, 'Karan', 'Trivedi', 'karan.trivedi@gmail.com', '2025-09-14'),
(110, 'Sneha', 'Dave', 'sneha.dave@gmail.com', '2025-10-01');

select * from Customers_table;


create table Orders_Table(
OrderId int primary key,
CustomerId int,
OrderDate date,
TotalAmount float,
FOREIGN KEY (CUSTOMERID) REFERENCES CUSTOMERS_table(CustomerID)
);

INSERT INTO Orders_Table VALUES
(1001, 101, '2026-01-05', 35000.00),
(1002, 102, '2026-01-12', 12500.50),
(1003, 103, '2026-02-01', 4500.00),
(1004, 104, '2026-02-15', 22000.75),
(1005, 105, '2026-03-03', 7500.00),
(1006, 106, '2026-03-18', 18000.25),
(1007, 107, '2026-04-10', 9500.00),
(1008, 108, '2026-05-05', 42000.00),
(1009, 109, '2026-06-15', 6700.50),
(1010, 110, '2026-07-20', 15000.00);

select * from Orders_table;

create table Employees_Table(
EmployeeID int primary key,
FirstName varchar(100),
Lastname varchar(100),
Department varchar(100),
HireDate date,
Salary float
);

insert into Employees_table Values
(201, 'Rahul', 'Sharma', 'Sales', '2022-01-15', 35000),
(202, 'Priya', 'Patel', 'Accounts', '2022-03-20', 42000),
(203, 'Amit', 'Kumar', 'IT', '2021-06-10', 55000),
(204, 'Neha', 'Mehta', 'HR', '2023-02-05', 38000),
(205, 'Rohan', 'Shah', 'Sales', '2023-05-12', 32000),
(206, 'Pooja', 'Joshi', 'Accounts', '2021-09-18', 48000),
(207, 'Vikas', 'Desai', 'IT', '2022-07-22', 62000),
(208, 'Anjali', 'Patel', 'HR', '2024-01-08', 36000),
(209, 'Karan', 'Trivedi', 'Sales', '2024-04-14', 40000),
(210, 'Sneha', 'Dave', 'IT', '2023-11-01', 58000);

select * from Employees_table;

# Useing Inner Join
select * from Customers_table as C
inner join Orders_table as O
on C.CustomerID=O.CustomerID;

# Useing Left Join
select * from Customers_table as C
left join Orders_table as O
on C.CustomerID=O.CustomerID;

# Useing Right Join
select * from Customers_table as C
right join Orders_table as O
on C.CustomerID=O.CustomerID;

# full outer join 
select * from Customers_table as C
left join Orders_table as O
on C.CustomerID=O.CustomerID
union
select * from Customers_table as C
right join Orders_table as O
on C.CustomerID=O.CustomerID;

SELECT o.OrderId, c.FirstName, c.LastName, o.TotalAmount
FROM Orders_Table o
INNER JOIN Customers_table c
ON o.CustomerId = c.CustomerID
WHERE o.TotalAmount > (
    SELECT AVG(TotalAmount)
    FROM Orders_Table
);

Select * from Employees_Table;

# Find Salaries above the avg. salary
SELECT EmployeeID, FirstName, Lastname, Salary
FROM Employees_Table
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees_Table
);

SELECT 
    OrderId,
    OrderDate,
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth
FROM Orders_Table;

SELECT OrderId,OrderDate,current_date() - OrderDate AS DaysDifference FROM Orders_Table;


SELECT OrderId,DATE_FORMAT(OrderDate, '%d-%m-%Y') AS OrderDate FROM Orders_Table; 

# FirstName + LastName → Full Name
SELECT 
    CustomerID,
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Customers_table;

# String replace
SELECT 
    REPLACE(FirstName, 'Rahul', 'Jonathan') AS FirstName
FROM Customers_table;

# FirstName uppercase + LastName lowercase
SELECT 
    UPPER(FirstName) AS FirstName,
    LOWER(LastName) AS LastName
FROM Customers_table;

# Email se extra spaces remove
SELECT 
    TRIM(Email) AS Email
FROM Customers_table;

# Running Total of TotalAmount
SELECT 
    OrderId,
    OrderDate,
    TotalAmount,
    SUM(TotalAmount) OVER (ORDER BY OrderDate) AS RunningTotal
FROM Orders_Table;

# TotalAmount ke basis par Rank
SELECT 
    OrderId,
    TotalAmount,
    RANK() OVER (ORDER BY TotalAmount DESC) AS OrderRank
FROM Orders_Table;

# TotalAmount ke basis par Discount
SELECT 
    OrderId,
    TotalAmount,
    CASE
        WHEN TotalAmount > 1000 THEN '10% Discount'
        WHEN TotalAmount > 500 THEN '5% Discount'
        ELSE 'No Discount'
    END AS Discount
FROM Orders_Table;

# Employee Salary ko High / Medium / Low categorize
SELECT 
    EmployeeID,
    FirstName,
    Salary,
    CASE
        WHEN Salary > 50000 THEN 'High'
        WHEN Salary >= 30000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Employees_Table;

