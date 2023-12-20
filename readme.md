# Northwind Traders Sales & Orders Analysis

An analysis of a fictional dataset about the sales and orders of a fictional gourmet food supplier named Northwind Traders.

The dataset is provided by the good people in [Maven Analytics](https://www.mavenanalytics.io/data-playground)

 Access the dashboard [here](https://app.powerbi.com/view?r=eyJrIjoiODljMTM1MjAtZTFjZi00N2Y3LWE1YjItNjg0MTgwNjJjYmNkIiwidCI6IjIzN2NkZmEwLWVmMWUtNDAxNS05ODRlLWI1NTM0YzhhNTZjYSJ9)
 Access the report [here](https://github.com/khaled-mehizel/HR-analysis/blob/main/GD%20HR%20report.pdf) or in the files.

# Goal
The purpose of this analysis is to build an airtight, intuitive, interactive, and reliable dashboard to allow the higher-ups of our company to gain key performance insights at a glance.
I also plan on putting together a report summarizing key insights, and some recommendations. Whether I'll do it in PowerBI or PowerPoint using those that neat add-in is something I'm still debating about. I hope I won't forget to update this section.
Or that's what I would've said if I didn't just install a VSCodium extension that bookmarks code hehe. Problem solved.

# Tools used:
- Notepad++ and its add-on, CSV Lint, for quick CSV importing into MySQL Workbench. It also allows you to set primary keys, constraints, it's an essential tool for any data analyst that uses SQL.
- MySQL Workbench for schema creation.
- Power BI for data modeling and visualization.
- PowerPoint for Reporting. maybe.


# Importing and Database Normalization
Using CSV Lint as usual: 
  - We get rid of unneeded columns like category descriptions. 
  - Do a little check on our data types and ensure validity
  - Convert the CSV file into a SQL script that creates a table, and inserts the values into it.
We also make sure to create our relational schema via the use of primary keys and foreign keys. By the time we've imported the data, it's normalized, and the model is created.

The schema is of the star variety.

## Cleaning
We inspect every table quickly in Excel to save time, they look to be in great shape, but we'll make sure in Excel all the same.
We'll load the tables into Power Query just to verify numbers and currencies.

## Modeling in Power BI
  - I disabled automatic relationship creation, so I had to manually recreate the model.
  - I also created a date table with the use of **CALENDAR()** that covers the entire dataset, it goes from 2013-07-04 to 2015-05-04. 
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
    