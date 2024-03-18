# Northwind Traders Sales & Orders Analysis

A dashboard for a fictional dataset about the sales and orders of a fictional gourmet food supplier named Northwind Traders.

The dataset is provided by the good people in [Maven Analytics](https://www.mavenanalytics.io/data-playground)

 Access the dashboard [here](https://app.powerbi.com/view?r=eyJrIjoiODljMTM1MjAtZTFjZi00N2Y3LWE1YjItNjg0MTgwNjJjYmNkIiwidCI6IjIzN2NkZmEwLWVmMWUtNDAxNS05ODRlLWI1NTM0YzhhNTZjYSJ9)
 Access the report [here](https://github.com/khaled-mehizel/HR-analysis/blob/main/GD%20HR%20report.pdf) or in the files.

# Goal
The purpose of this project is to build an airtight, intuitive, interactive, and reliable dashboard to allow the higher-ups of Northwind Traders to acquire monthly information about the health of the business and derive insights to move forward.
It's meant for executives, so it's not as granular as it would be if it were meant for business analysts to use.

# Tools used:
- Notepad++ and its add-on, CSV Lint, for quick CSV importing into MySQL Workbench. It also allows you to set primary keys, constraints, it's an essential tool for any data analyst that uses SQL.
- MySQL Workbench for schema creation.
- Power BI for data modeling and visualization.
- A script written by Mitchell of [Pragmatic Works](https://www.youtube.com/watch?v=kRsETkmatEo) that automatically generates a date column based on dates specified by the user. I tried Gemini at first but this is foolproof.


# Importing and Database Normalization
Using CSV Lint as usual: 
  - We get rid of unneeded columns like category descriptions. 
  - Do a little check on our data types and ensure validity.
  - Convert the CSV file into a SQL script that creates a table, and inserts the values into it.
We also make sure to create our relational schema via the use of primary keys and foreign keys. By the time we've imported the data, it's normalized, and the model is created.

The schema is of the star variety.

## Cleaning
We inspect every table quickly in Excel to save time, they look to be in great shape, but we'll make sure in Excel all the same.
We'll load the tables into Power Query just to verify numbers and currencies.
- Added an "Is Shipped" conditional column.
- Got rid of April 2015 as it was only 4 days in. The dashboard is to measure monthly peformance of the business.

## Modeling in Power BI
  - I disabled automatic relationship creation, so I had to manually recreate the model.
  - I also created a date table in Power Query using the aforementioned that covers the entire dataset, it goes from 2013-07-04 to 2015-03-31.
    - I could've used **CALENDAR()** in DAX instead, but this method allows me to manipulate the table in Power Query and it is much easier to go about it that way.
  - I split the date table into Year, Quarter, and Month to take advantage of time intelligence functions later.
  - Ensure that city and country fields are marked as geospatial.
  - Add a discounted price field using Power Query. Could also use DAX but eh.
  - Replaced the values in the Discontinued? field with a Yes or No.

# Visualization
  - First things first, we'll need some DAX measures, some KPIs measuring performance etc.
    - A total sales KPI comparing current sales to last month's using **CALCULATE()** and **DATEADD()**
 c
  - I wanted to use the new slicer with the images. But I needed a column with the image URLs, the way I went about this is creating an Excel file that relates each category with an image, then importing it as a CSV file, and creating a relationship in Power BI.
    I really like how it looks, heh. The icons are not consistent in style, though. Sorry about that.
    