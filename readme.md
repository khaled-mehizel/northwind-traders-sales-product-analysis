# Northwind Traders Sales & Orders Analysis

A dashboard for a fictional dataset about the sales and orders of a fictional gourmet food supplier named Northwind Traders.

The dataset is provided by the good people in [Maven Analytics](https://www.mavenanalytics.io/data-playground)

 Access the dashboard [here](https://app.powerbi.com/view?r=eyJrIjoiODljMTM1MjAtZTFjZi00N2Y3LWE1YjItNjg0MTgwNjJjYmNkIiwidCI6IjIzN2NkZmEwLWVmMWUtNDAxNS05ODRlLWI1NTM0YzhhNTZjYSJ9)
 Access the report [here](https://github.com/khaled-mehizel/HR-analysis/blob/main/GD%20HR%20report.pdf) or in the files.

## Goal

The purpose of this project is to build an airtight, intuitive, interactive, and reliable dashboard to allow the higher-ups of Northwind Traders to acquire monthly information about the health of the business and derive insights to move forward.
It's meant for executives, so it's not as granular as it would be if it were meant for business analysts to use.

## Tools used

- Notepad++ and its add-on, CSV Lint, for quick CSV importing into MySQL Workbench. It also allows you to set primary keys, constraints, it's an essential tool for any data analyst that uses SQL.
- MySQL Workbench for schema creation.
- Power BI for data modeling and visualization.
- [SVGRepo](https://www.svgrepo.com) for slicer icons. I recommend it because it's quite hassle-free.
- A script written by Mitchell of [Pragmatic Works](https://www.youtube.com/watch?v=kRsETkmatEo) that automatically generates a date column based on dates specified by the user. I tried Gemini at first but this is foolproof.

## Insights

### Beverages are the most expensive product category in terms of shipping costs, followed by Dairy products

INSERT IMAGE FROM POWER BI

## Importing and Database Normalization

In Excel, we perform the following:

- Checking data types is standard procedure, ensuring consistent date formatting, currencies, etc.
- Only blank values are for non-shipped orders.
- No duplicates are found.

Using CSV Lint as usual:

- We get rid of unneeded columns like category descriptions.
- Do a little check on our data types and ensure validity.
- Convert the CSV file into a SQL script that creates a table, and inserts the values into it.
We also make sure to create our relational schema via the use of constraints, primary keys and foreign keys. By the time we've imported the data, it's normalized, and the model is created.

## Exploratory Data Analysis

### Order Fact table

  Very interesting box plot:
  !["Freight price box plot"](/northwind-traders-sales-product-analysis/images/box.png)

- A ton of outliers, we can verify if these outliers are accurate by joining the Order Details lookup table, we can join them in SQL, I know we could've done the same in Power Pivot but I chose SQL because I wanted to and not because I forgot, haha. Even though it would've been so much easier, haha.

    The shipping prices can be this high due to multiple factors, such as category, destination country:
  
- We can start by taking a look at the Product Category, as fragile categories will cost a lot more to ship.
  - Customer Country is a large factor, Northwind Traders are based in the US, so shipping to Germany is not like shipping to Brazil, for example.
- We have come up with the following query:

            SELECT 
              o.orderID AS 'Order ID',
              o.freight AS 'Shipping Price',
              od.productID AS 'Product ID',
              cat.categoryname AS "Category",
              cus.customerID AS "CustomerID",
              cus.Country AS "Destination Country"
            FROM orders o
            JOIN order_details od ON od.orderID = o.orderID
            JOIN products p ON p.productID = od.productID
            JOIN categories cat ON cat.categoryID = p.categoryID
            JOIN customers cus ON cus.customerID = o.customerID
            ORDER BY 2 DESC,1;
  - We'll extract this table into Excel, and try to gain if these factors have any contribution at all, using Pivot Tables
- As seen in the [insight section](#insights), product category is a big factor.
- Removing the outliers does very little to change average shipping costs when it comes to both destination countries and product category.
    !["top 10 countries by shipping price"](/northwind-traders-sales-product-analysis/images/top10%20countries%20by%20shipping%20prices.png)
    !["Shipping price by category"](/northwind-traders-sales-product-analysis/images/category_shipping.png)
- Checking the average shipping price per customer, removing the outliers encountered earlier does not change the chart very much (notice the axis), thus I'm inclined to believe that the outliers are **accurate** and there's no need to remove them.
- Freight fees seem to vary from $0.02 all the way to $1007.64, the second highest is $890.78 - a difference of $116.86 or 13.11%. 
  - The really expensive item seems to be fancy champagne, with a unit price of $263.50
    - After testing the average freight fees per month, it seems that the champagne has very little bearing on the average, so there's no need to rule it out.
    - 

- Got rid of May 2015 as it was only 4 days in. The dashboard is to measure monthly peformance of the business.
  - If only there were a SAMEPERIODLASTMONTH() function in DAX.
- Ensured that city and country fields are marked as geospatial.

## Modeling in Power BI
data model
- I created the model in a snowflake-schema, making sure to use one-to-many relationship with downward-flowing filters, and connected the product lookup table to the order table through the order detail table via order_id and product_id.
  - I also created a date table in Power Query using the aforementioned that covers the entire dataset, it goes from 2013-07-04 to 2015-03-31.
    - I could've used **CALENDAR()** in DAX instead, but this method allows me to manipulate the table in Power Query and it is much easier to go about it that way.
  - Set the primary keys for each table in the model view.
  - Moved all the measures into a folder of their own, aptly named "All Measures".
  - I split the date table into Year, Quarter, and Month to take advantage of time intelligence functions later.
  - Add a discounted price field using Power Query. Could also use DAX.
  - Replaced the values in the Discontinued? field with a Yes or No.
  - Added an "Is Shipped" conditional column for use with the shipping time calculated column.
  - Added a "Shipped on time?" conditional column to calculate the percentage of the orders shipped on time per shipper.
  - Calculated the aforementioned column using **DATEDIFF()** nested in an **IF()** function, to only calculate the shipping time of the orders that were actually shipped.
    - This was actually pointless because **DATEDIFF()** actually ignores null values (a.k.a. orders that haven't been shipped yet), I'll still leave it!

    ```
    Shipping Time = IF('orders'[Is Shipped] = "YES", DATEDIFF(orders[orderDate],orders[shippedDate],DAY))
    ```

  - Added a calculated column that shows the average shipping time for each shipping company using **AVERAGEX()**. The tables are related using the shipper_id column.

    ```
    Avg. Shipping Time = AVERAGEX(RELATEDTABLE(orders),orders[Shipping Time])
    ```

      - Average 
  - Added a table imported from a CSV file that contains categoryID and a URL for an SVG file that serves as the slicer icon. The table is related to the Category Lookup table.

  This is the data model we're going to use for our analysis:
      !["Northwind Data Model"](Images/Northwind%20Data%20Model.JPG)

## Visualization

- First things first, we'll need some DAX measures, some KPIs measuring performance etc.
  - A total sales KPI comparing current sales to last month's using **CALCULATE()** and **DATEADD()**

For KPIs, I decided to go about it differently, because even the new card visual is kinda boring, the sparklines just don't do it for me.
- I wanted to use the new slicer with the images. But I needed a column with the image URLs, the way I went about this is creating an Excel file that relates each category with an image, then importing it as a CSV file, and creating a relationship in Power BI using the categoryID primary key.
- The following screenshot shows the rest of the measures: 
    ![Measures](Images/measures.JPG)

    PREVIOUS MONTH CALCULATOR

    To create the KPI, I needed to filter the Current Month Revenue, but filtering it using an ordinary slicer would turn the line chart into a single point. Disabling the slicer interaction would break the title we worked so hard on! So we used the seperate date table in a DAX measure that changes ONLY the title based on the selected value, disabled all of its interactions with everything except the KPI itself, and synchronized it with the global slicer, and hid it from the end-user
      - The end result is that we get to filter only the title by date, and leave the line chart be. It's ugly but it works! Just gotta figure out how to make the KPI slicer bound to the main slicer.
        - I synchronized them by giving them the same group name in the "Sync Slicer" menu!
EOMONTH VS EDATE
https://learn.microsoft.com/en-us/dax/format-function-dax