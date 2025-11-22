CREATE DATABASE e_commerce_order_trends;
use e_commerce_order_trends;

CREATE TABLE Users (
UserID INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100) UNIQUE,
PasswordHash VARCHAR(255),
Role ENUM('Admin', 'Customer'),
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Customers (
CustomerID INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
Address TEXT,
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE Products (
ProductID INT AUTO_INCREMENT PRIMARY KEY,
ProductName VARCHAR(100),
Category VARCHAR(50),
Price DECIMAL(10, 2),
Stock INT,
Description TEXT,
ImageURL VARCHAR(255),
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE Orders (
OrderID INT AUTO_INCREMENT PRIMARY KEY,
CustomerID INT,
OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
TotalAmount DECIMAL(10, 2),
Status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled'),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);



CREATE TABLE OrderDetails (
OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT,
Price DECIMAL(10, 2),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


CREATE TABLE Coupons (
CouponID INT AUTO_INCREMENT PRIMARY KEY,
Code VARCHAR(50),
DiscountPercentage DECIMAL(5, 2),
ExpiryDate DATE,
UsageLimit INT,
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE OrderCoupons (
OrderCouponID INT AUTO_INCREMENT PRIMARY KEY,
OrderID INT,
CouponID INT,
DiscountAmount DECIMAL(10, 2),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (CouponID) REFERENCES Coupons(CouponID)
);


CREATE TABLE ProductReviews (
ReviewID INT AUTO_INCREMENT PRIMARY KEY,
ProductID INT,
CustomerID INT,
Rating INT CHECK (Rating BETWEEN 1 AND 5),
ReviewText TEXT,
ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE Shipments (
ShipmentID INT AUTO_INCREMENT PRIMARY KEY,
OrderID INT,
Carrier VARCHAR(100),
TrackingNumber VARCHAR(100),
ShippedDate TIMESTAMP,
EstimatedDeliveryDate TIMESTAMP,
DeliveredDate TIMESTAMP,
Status ENUM('Shipped', 'In Transit', 'Delivered', 'Failed'),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);


CREATE TABLE Cart (
CartID INT AUTO_INCREMENT PRIMARY KEY,
CustomerID INT,
ProductID INT,
Quantity INT,
AddedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- INSERT VALUES INTO THE TABLE 

INSERT INTO Users (Name, Email, PasswordHash, Role)
VALUES
('Admin User', 'admin@example.com', 'hashedpassword1', 'Admin'),
('John Doe', 'john.doe@example.com', 'hashedpassword2', 'Customer'),
('Jane Smith', 'jane.smith@example.com', 'hashedpassword3', 'Customer'),
('Alice Brown', 'alice.brown@example.com', 'hashedpassword4', 'Customer'),
('Bob White', 'bob.white@example.com', 'hashedpassword5', 'Customer'),
('Michael Brown', 'michael.brown@example.com', 'hashedpassword4', 'Customer'),
('Sarah Johnson', 'sarah.johnson@example.com', 'hashedpassword5', 'Customer');

INSERT INTO Customers (Name, Email, Phone, Address)
VALUES
('John Doe', 'john.doe@example.com', '1234567890', '123 Elm St, New York'),
('Jane Smith', 'jane.smith@example.com', '0987654321', '456 Oak St, California'),
('Alice Brown', 'alice.brown@example.com', '1122334455', '789 Pine St, Texas'),
('Bob White', 'bob.white@example.com', '5566778899', '159 Maple St, Florida'),
('Michael Brown', 'michael.brown@example.com', '1122334455', '789 Pine St, Texas'),
('Sarah Johnson', 'sarah.johnson@example.com', '6677889900', '321 Birch St, Florida');


INSERT INTO Products (ProductName, Category, Price, Stock, Description, ImageURL)
VALUES
('Laptop', 'Electronics', 1000.00, 20, 'High-performance laptop', 'http://example.com/laptop.jpg'),
('Headphones', 'Accessories', 50.00, 100, 'Noise-cancelling headphones', 'http://example.com/headphones.jpg'),
('Smartphone', 'Electronics', 800.00, 30, 'Latest smartphone model', 'http://example.com/smartphone.jpg'),
('Backpack', 'Accessories', 40.00, 50, 'Stylish and durable backpack', 'http://example.com/backpack.jpg'),
('Gaming Console', 'Electronics', 500.00, 15, 'Next-gen gaming console', 'http://example.com/console.jpg'),
('Wireless Mouse', 'Accessories', 25.00, 200, 'Ergonomic wireless mouse', 'http://example.com/mouse.jpg'),
('Smartwatch', 'Electronics', 300.00, 40, 'Feature-packed smartwatch', 'http://example.com/smartwatch.jpg');


INSERT INTO Orders (CustomerID, TotalAmount, Status, OrderDate)
VALUES
(1, 1050.00, 'Shipped', '2024-12-01'),
(2, 850.00, 'Delivered', '2024-11-28'),
(3, 525.00, 'Delivered', '2024-11-30'),
(4, 325.00, 'Shipped', '2024-12-05');


INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES
(1, 1, 1, 1000.00),
(1, 2, 1, 50.00),
(2, 3, 1, 800.00),
(2, 4, 1, 40.00),
(3, 5, 1, 500.00),
(3, 6, 1, 25.00),
(4, 7, 1, 300.00);


INSERT INTO Coupons (Code, DiscountPercentage, ExpiryDate, UsageLimit)
VALUES
('WELCOME10', 10.00, '2024-12-31', 100),
('FESTIVE20', 20.00, '2024-12-25', 50),
('HOLIDAY15', 15.00, '2024-12-31', 75);



INSERT INTO OrderCoupons (OrderID, CouponID, DiscountAmount)
VALUES
(1, 1, 100.00),
(2, 2, 170.00),
(3, 3, 78.75);



INSERT INTO ProductReviews (ProductID, CustomerID, Rating, ReviewText)
VALUES
(1, 1, 5, 'Excellent laptop! Highly recommend.'),
(2, 2, 4, 'Great headphones, but a bit pricey.'),
(5, 3, 5, 'Amazing gaming experience!'),
(6, 4, 4, 'Great wireless mouse, very responsive.');



INSERT INTO Shipments (OrderID, Carrier, TrackingNumber, ShippedDate, EstimatedDeliveryDate, DeliveredDate, Status)
VALUES
(1, 'FedEx', 'TRACK123', '2024-12-02', '2024-12-05', NULL, 'In Transit'),
(2, 'UPS', 'TRACK456', '2024-11-29', '2024-12-03', '2024-12-03', 'Delivered'),
(3, 'DHL', 'TRACK789', '2024-12-01', '2024-12-06', '2024-12-06', 'Delivered'),
(4, 'FedEx', 'TRACK101', '2024-12-06', '2024-12-10', NULL, 'In Transit');



INSERT INTO Cart (CustomerID, ProductID, Quantity, AddedDate)
VALUES
(1, 4, 1, '2024-12-10'),
(2, 2, 2, '2024-12-09'),
(3, 7, 1, '2024-12-08'),
(4, 5, 1, '2024-12-09');
-- Q1 What are the average prices of products by category, filtered to only show categories with an average price greater than $100? --
SELECT
  Category,
  ROUND(AVG(Price), 2) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 100;
-- Q2. What are the top 5 best-selling products? --
SELECT
  p.ProductID,
  p.ProductName,
  COALESCE(SUM(od.Quantity), 0) AS TotalQuantitySold
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalQuantitySold DESC, p.ProductID
LIMIT 5;
-- Q3 Write a trigger that automatically updates the stock of a product when an order is placed. --
DELIMITER $$

CREATE TRIGGER trg_after_orderdetail_insert
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
  -- optional: prevent negative stock
  IF EXISTS (
    SELECT 1 FROM Products
    WHERE ProductID = NEW.ProductID AND Stock < NEW.Quantity
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for product';
  END IF;

  UPDATE Products
  SET Stock = Stock - NEW.Quantity
  WHERE ProductID = NEW.ProductID;
END$$

DELIMITER ;
-- Q4 Which products have received 5-star reviews? --
SELECT DISTINCT p.ProductID, p.ProductName
FROM Products p
JOIN ProductReviews r ON p.ProductID = r.ProductID
WHERE r.Rating = 5;
-- Q5 How much discount has been applied to each order? --
SELECT
  o.OrderID,
  o.TotalAmount,
  COALESCE(SUM(oc.DiscountAmount), 0) AS TotalDiscountApplied
FROM Orders o
LEFT JOIN OrderCoupons oc ON o.OrderID = oc.OrderID
GROUP BY o.OrderID, o.TotalAmount
ORDER BY o.OrderID;
-- Q6 How many orders were placed each month? --
SELECT
  DATE_FORMAT(OrderDate, '%Y-%m') AS YearMonth,
  COUNT(*) AS OrdersCount
FROM Orders
GROUP BY YearMonth
ORDER BY YearMonth;
-- Q7 Create a view that shows all orders along with customer names and order statuses, and how can you query this view to get all 'Shipped' orders? --
CREATE VIEW OrdersWithCustomer AS
SELECT
  o.OrderID,
  o.CustomerID,
  c.Name AS CustomerName,
  o.OrderDate,
  o.TotalAmount,
  o.Status
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;
SELECT *
FROM OrdersWithCustomer
WHERE Status = 'Shipped';
-- Q8 Which customers have spent the most? --
WITH OrderDiscounts AS (
  SELECT OrderID, COALESCE(SUM(DiscountAmount), 0) AS OrderDiscount
  FROM OrderCoupons
  GROUP BY OrderID
)
SELECT
  c.CustomerID,
  c.Name,
  ROUND(COALESCE(SUM(o.TotalAmount - COALESCE(od.OrderDiscount,0)),0), 2) AS TotalSpent
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN OrderDiscounts od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.Name
ORDER BY TotalSpent DESC;
-- Q9 What is the average rating and total reviews for each product? --
SELECT
  p.ProductID,
  p.ProductName,
  ROUND(AVG(r.Rating), 2) AS AvgRating,
  COUNT(r.ReviewID) AS ReviewCount
FROM Products p
LEFT JOIN ProductReviews r ON p.ProductID = r.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY ReviewCount DESC, AvgRating DESC;
-- Q10 How many shipments were handled by each carrier? --
SELECT
  Carrier,
  COUNT(*) AS ShipmentsCount
FROM Shipments
GROUP BY Carrier
ORDER BY ShipmentsCount DESC;
-- Which orders were placed in the year 2024? --
SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 2024;
-- How can you rank customers based on their total spending using a window function? --
WITH CustomerTotals AS (
  SELECT
    c.CustomerID,
    c.Name,
    COALESCE(SUM(o.TotalAmount - COALESCE(oc.TotalDiscount,0)), 0) AS TotalSpent
  FROM Customers c
  LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
  LEFT JOIN (
    SELECT OrderID, SUM(DiscountAmount) AS TotalDiscount
    FROM OrderCoupons
    GROUP BY OrderID
  ) oc ON o.OrderID = oc.OrderID
  GROUP BY c.CustomerID, c.Name
)
SELECT
  CustomerID,
  Name,
  TotalSpent,
  RANK() OVER (ORDER BY TotalSpent DESC) AS SpendingRank
FROM CustomerTotals
ORDER BY SpendingRank;
-- What is the delivery time for each completed order? --
SELECT
  o.OrderID,
  s.ShippedDate,
  s.DeliveredDate,
  DATEDIFF(s.DeliveredDate, s.ShippedDate) AS DeliveryDays
FROM Orders o
JOIN Shipments s ON o.OrderID = s.OrderID
WHERE s.DeliveredDate IS NOT NULL;
-- How can products be categorized by price range? --
SELECT
  ProductID,
  ProductName,
  Price,
  CASE
    WHEN Price < 50 THEN 'Budget'
    WHEN Price BETWEEN 50 AND 299.99 THEN 'Mid'
    WHEN Price >= 300 THEN 'Premium'
    ELSE 'Unknown'
  END AS PriceCategory
FROM Products
ORDER BY Price DESC;
-- How many unique delivered orders were made by each customer? --
SELECT
  c.CustomerID,
  c.Name,
  COUNT(DISTINCT o.OrderID) AS DeliveredOrdersCount
FROM Customers c
LEFT JOIN Orders o
  ON c.CustomerID = o.CustomerID
  AND o.Status = 'Delivered'
GROUP BY c.CustomerID, c.Name
ORDER BY DeliveredOrdersCount DESC;
----














