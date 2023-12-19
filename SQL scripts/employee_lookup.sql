-- -------------------------------------
-- CSV Lint plug-in v0.4.6.2
-- File: employees.csv
-- Date: 18-Dec-2023 11:11
-- SQL type: mySQL
-- -------------------------------------
CREATE TABLE employees (
	`employeeID` int NOT NULL,
	`employeeName` varchar(16),
	`title` varchar(20),
	`city` varchar(8),
	`country` varchar(3),
	primary key(`employeeID`)
);

-- -------------------------------------
-- insert records 1 - 9
-- -------------------------------------
insert into employees (
	`employeeID`,
	`employeeName`,
	`title`,
	`city`,
	`country`
) values
(1, 'Nancy Davolio', 'Sales Representative', 'New York', 'USA'),
(2, 'Andrew Fuller', 'Vice President Sales', 'New York', 'USA'),
(3, 'Janet Leverling', 'Sales Representative', 'New York', 'USA'),
(4, 'Margaret Peacock', 'Sales Representative', 'New York', 'USA'),
(5, 'Steven Buchanan', 'Sales Manager', 'London', 'UK'),
(6, 'Michael Suyama', 'Sales Representative', 'London', 'UK'),
(7, 'Robert King', 'Sales Representative', 'London', 'UK'),
(8, 'Laura Callahan', 'Sales Manager', 'New York', 'USA'),
(9, 'Anne Dodsworth', 'Sales Representative', 'London', 'UK');

