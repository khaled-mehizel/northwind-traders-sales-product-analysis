-- -------------------------------------
-- CSV Lint plug-in v0.4.6.2
-- File: categories.csv
-- SQL type: mySQL
-- -------------------------------------
CREATE TABLE categories (
	`categoryID` integer NOT NULL,
	`categoryName` varchar(16),
	primary key(`categoryID`)
);

-- -------------------------------------
-- insert records 1 - 8
-- -------------------------------------
insert into categories (
	`categoryID`,
	`categoryName`
) values
(1, 'Beverages'),
(2, 'Condiments'),
(3, 'Confections'),
(4, 'Dairy Products'),
(5, 'Grains & Cereals'),
(6, 'Meat & Poultry'),
(7, 'Produce'),
(8, 'Seafood');

