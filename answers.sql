--QUESTION 1
/*Creare new table*/
CREATE TABLE OrderProducts (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

INSERT INTO OrderProducts (OrderID, CustomerName, Product)
SELECT
    pd.OrderID,
    pd.CustomerName,
    TRIM(value) AS Product
FROM ProductDetail pd
CROSS APPLY STRING_SPLIT(pd.Products, ',');

SELECT * FROM OrderProducts; /*Display table content*/


--QUESTION 2
/*Create a new table for Customers*/
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT, -- Assuming an auto-incrementing ID
    CustomerName VARCHAR(255)
);

/*Create a new table for Orders*/
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

/*table for OrderItems*/
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

/*Customers table*/
INSERT INTO Customers (CustomerName)
SELECT DISTINCT CustomerName
FROM OrderDetails;

/*Orders table*/
INSERT INTO Orders (OrderID, CustomerID)
SELECT DISTINCT od.OrderID, c.CustomerID
FROM OrderDetails od
JOIN Customers c ON od.CustomerName = c.CustomerName;

/*OrderItems table*/
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

/*Display cutomers*/
SELECT * FROM Customers;
/*Display orders*/
SELECT * FROM Orders;
/*Display orderItems*/
SELECT * FROM OrderItems;
