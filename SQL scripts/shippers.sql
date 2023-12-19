-- -------------------------------------
-- CSV Lint plug-in v0.4.6.2
-- File: shippers.csv
-- Date: 18-Dec-2023 11:16
-- SQL type: mySQL
-- -------------------------------------
CREATE TABLE shippers (
	`shipperID` integer NOT NULL,
	`companyName` varchar(16),
	primary key(`shipperID`)
);

-- -------------------------------------
-- insert records 1 - 3
-- -------------------------------------
insert into shippers (
	`shipperID`,
	`companyName`
) values
(1, 'Speedy Express'),
(2, 'United Package'),
(3, 'Federal Shipping');

