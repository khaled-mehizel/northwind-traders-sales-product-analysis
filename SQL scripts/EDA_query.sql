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