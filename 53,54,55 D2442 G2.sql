
/*Major Project Report 
on 
Project Title: - Online Grocery Store 
Course: Advanced Database Techniques 
Course Code: CAP570 

Section-D2442 G2
Submitted by 
1. Sricharan Boggavarapu (12402606),53 Group: - 2 
2. Ankna Chaudhary (12408388),54 Group: -2 
3. Sanjana Sherawat (12408497),55 Group: -2

Submitted to 
Ms. Ranjit Kaur Walia 
UID: 28632 
Assistant Professor, SCA, LPU 

*/






create database MinorProject
use MinorProject

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    email NVARCHAR(100) UNIQUE,
    phone_number NVARCHAR(15),
    address NVARCHAR(255)
);
/*1NF: All attributes contain atomic values (e.g., one phone number per row).
2NF: All non-key attributes (first_name, last_name, etc.) are fully dependent on the primary key (customer_id).
3NF: No transitive dependency as all attributes are directly related to customer_id.*/
CREATE TABLE Products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name NVARCHAR(100),
    category_id INT,
    price DECIMAL(10, 2),
    stock INT,
    description NVARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
/*1NF: Each product has atomic values (e.g., one price, one stock value).
2NF: Each attribute is fully dependent on the primary key (product_id).
3NF: No transitive dependencies (category information is linked through category_id).*/
CREATE TABLE Categories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name NVARCHAR(100) UNIQUE
);
/*1NF: Atomic values for category_name.
2NF: No partial dependencies (since category_id is the only key).
3NF: No transitive dependencies.*/
CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10, 2),
    status NVARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
/*1NF: Atomic values (one date, one total_amount).
2NF: All non-key attributes depend on order_id.
3NF: No transitive dependencies.*/
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
/*1NF: Atomic values.
2NF: Attributes like quantity and price depend on both order_id and product_id.
3NF: No transitive dependencies.*/
CREATE TABLE Cart (
    cart_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
/*1NF: Each cart entry contains atomic values.
2NF: All attributes depend on the composite key (cart_id).
3NF: No transitive dependencies.*/
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    payment_date DATETIME,
    payment_method NVARCHAR(50),
    amount DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
/*1NF: Atomic values.
2NF: All attributes depend on payment_id.
3NF: No transitive dependencies.*/
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY IDENTITY(1,1),
    supplier_name NVARCHAR(100),
    contact_info NVARCHAR(255)
);
/*1NF: Atomic values.
2NF: All attributes depend on supplier_id.
3NF: No transitive dependencies.
*/
CREATE TABLE SupplierProducts (
    supplier_product_id INT PRIMARY KEY IDENTITY(1,1),
    supplier_id INT,
    product_id INT,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
/*1NF: Atomic values.
2NF: No partial dependency (both supplier_id and product_id are required).
3NF: No transitive dependency.*/

---insert values into Customers table
INSERT INTO Customers (first_name, last_name, email, phone_number, address)
VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St, New York, NY'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321', '456 Oak Ave, Los Angeles, CA');

---insert values into Categories table
INSERT INTO Categories (category_name)
VALUES
('Fruits'),
('Vegetables'),
('Dairy');
select * from Products
--insert into products table

INSERT INTO Products (product_name, category_id, price, stock, description)
VALUES
('Apple', 1, 2.50, 100, 'Fresh red apples'),
('Banana', 1, 1.00, 200, 'Ripe yellow bananas'),
('Carrot', 2, 1.20, 150, 'Crunchy orange carrots'),
('Broccoli', 2, 1.50, 80, 'Fresh green broccoli heads'),
('Milk', 3, 3.00, 50, 'Whole milk from local farms'),
('Cheese', 3, 5.00, 30, 'Cheddar cheese block');

INSERT INTO Suppliers (supplier_name, contact_info)
VALUES
('FreshFarms', 'Michael Adams, 555-1234, freshfarms@example.com'),
('DailyDairy', 'Sarah Connor, 555-9876, dailydairy@example.com'),
('GreenGrocer', 'Tom Hanks, 555-4321, greengrocer@example.com'),
('Fruitful Harvest', 'Lucy Liu, 555-6789, fruitfulharvest@example.com');

INSERT INTO SupplierProducts (supplier_id, product_id)
VALUES
(1, 1),  -- FreshFarms supplies Apples
(1, 3),  -- FreshFarms supplies Carrots
(2, 5),  -- DailyDairy supplies Milk
(3, 6);  -- GreenGrocer supplies Cheese

INSERT INTO Orders (customer_id, order_date, total_amount, status)
VALUES
(1, GETDATE(), 15.50, 'Pending'),  -- Order for Customer 1
(2, GETDATE(), 8.00, 'Completed'),  -- Order for Customer 2
(1, GETDATE(), 25.75, 'Shipped'),    -- Another order for Customer 1
(2, GETDATE(), 12.50, 'Pending');    -- Another order for Customer 2

select * from Cart
INSERT INTO Cart (customer_id, product_id, quantity)
VALUES
(1, 1, 5),  -- Customer 1 adds 5 Apples to their cart
(1, 3, 2),  -- Customer 1 adds 2 Carrots to their cart
(2, 2, 3),  -- Customer 2 adds 3 Bananas to their cart
(2, 5, 1);  -- Customer 2 adds 1 Milk to their cart

INSERT INTO OrderDetails (order_id, product_id, quantity, price)
VALUES
(1, 1, 5, 2.50),  -- Order 1 includes 5 Apples at $2.50 each
(1, 3, 2, 1.20),  -- Order 1 includes 2 Carrots at $1.20 each
(2, 2, 3, 1.00),  -- Order 2 includes 3 Bananas at $1.00 each
(3, 5, 1, 3.00);  -- Order 3 includes 1 Milk at $3.00


INSERT INTO Payments (order_id, payment_date, payment_method, amount)
VALUES
(1, GETDATE(), 'Credit Card', 15.50),  -- Payment for Order 1
(2, GETDATE(), 'Debit Card', 8.00),     -- Payment for Order 2
(3, GETDATE(), 'PayPal', 25.75),        -- Payment for Order 3
(4, GETDATE(), 'Cash', 12.50);          -- Payment for Order 4

-------------------------------------------------------------------------------------------------------------
/*Static Transaction for updating the stock of a product after a customer places an order.*/
BEGIN TRY
    BEGIN TRANSACTION;

    -- Step 1: Insert a new order
    INSERT INTO Orders (customer_id, order_date, total_amount, status)
    VALUES (1, GETDATE(), 150.00, 'Processing'); 

    -- Get the last inserted order ID
    DECLARE @OrderID INT = SCOPE_IDENTITY();
    DECLARE @ProductID INT = 1;  -- Assuming product_id = 1 for this example
    DECLARE @Quantity INT = 5;   -- Assuming the customer purchased 5 units
    DECLARE @Stock INT;

    -- Step 2: Check current stock level
    SELECT @Stock = stock FROM Products WHERE product_id = @ProductID;

    -- Check if there is enough stock
    IF @Stock < @Quantity
    BEGIN
        PRINT 'Not enough stock available';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Step 3: Insert order details
    INSERT INTO OrderDetails (order_id, product_id, quantity, price)
    VALUES (@OrderID, @ProductID, @Quantity, 30.00);  -- Assuming price = 30.00

    -- Step 4: Update the product stock
    UPDATE Products
    SET stock = stock - @Quantity
    WHERE product_id = @ProductID;

    -- Commit the transaction if everything is successful
    COMMIT TRANSACTION;
    PRINT 'Transaction completed successfully. Product stock updated.';
    
END TRY
BEGIN CATCH
    -- Rollback the transaction if there is an error
    ROLLBACK TRANSACTION;
    PRINT 'Transaction failed. Changes rolled back.';
    PRINT ERROR_MESSAGE();
END CATCH;
------------------------------------------------------------------------------------------------------------

/*STORED PROCEDURE*/

/* Add New Customer*/
CREATE PROCEDURE AddNewCustomer
    @first_name NVARCHAR(50),
    @last_name NVARCHAR(50),
    @email NVARCHAR(100),
    @phone_number NVARCHAR(20),
    @address NVARCHAR(255)
AS
BEGIN
    INSERT INTO Customers (first_name, last_name, email, phone_number, address)
    VALUES (@first_name, @last_name, @email, @phone_number, @address);
    PRINT 'Customer added successfully';
END;
/*EXEC AddNewCustomer 
    @first_name = 'Alice', 
    @last_name = 'Smith', 
    @email = 'alice.smith@example.com', 
    @phone_number = '1234567890', 
    @address = '456 Oak Street, City';*/

select * from Customers


-------------------------------------------------------------------------------------------------------------
/*Creating A Function */
---User-Defined Function: Calculate Total Revenue for a Product
CREATE FUNCTION CalculateTotalRevenue (@product_id INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @total_revenue DECIMAL(10, 2);

    -- Calculate total revenue by summing (quantity * price) for the given product
    SELECT @total_revenue = SUM(quantity * price)
    FROM OrderDetails
    WHERE product_id = @product_id;

    -- If no orders exist for the product, set revenue to 0
    IF @total_revenue IS NULL
        SET @total_revenue = 0;

    RETURN @total_revenue;
END;

---using the created function
SELECT dbo.CalculateTotalRevenue(1) AS Total_Revenue;

select * from Products
select * from OrderDetails
---------------------------------------------------------------------------------------------------
/*Creating an Dynamic Cursor to Restocking the products that have lower stock*/
DECLARE @product_id INT;
DECLARE @product_name NVARCHAR(100);
DECLARE @current_stock INT;
DECLARE @threshold INT = 150; -- Minimum stock level before restocking
DECLARE @restock_amount INT = 50; -- Amount to restock if stock is low

-- Declare a dynamic cursor
DECLARE LowStockCursor CURSOR FOR
    SELECT product_id, product_name, stock
    FROM Products
    WHERE stock < @threshold;

-- Open the cursor
OPEN LowStockCursor;

-- Fetch the first row into the variables
FETCH NEXT FROM LowStockCursor INTO @product_id, @product_name, @current_stock;

-- Loop through the rows
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Print the current product details
    PRINT 'Restocking product: ' + @product_name + ' (Product ID: ' + CAST(@product_id AS NVARCHAR) + ')';
    PRINT 'Current Stock: ' + CAST(@current_stock AS NVARCHAR);

    -- Update the stock for the product
    UPDATE Products
    SET stock = stock + @restock_amount
    WHERE product_id = @product_id;

    -- Print the new stock status
    PRINT 'New Stock Level: ' + CAST(@current_stock + @restock_amount AS NVARCHAR);

    -- Fetch the next row
    FETCH NEXT FROM LowStockCursor INTO @product_id, @product_name, @current_stock;
END;

-- Close and deallocate the cursor
CLOSE LowStockCursor;
DEALLOCATE LowStockCursor;
select * from Products

----------------------------------------------------------------------------------------------------------
/* Trigger: Update Product Stock on Order Placement*/
-- Creating the trigger
CREATE TRIGGER trg_UpdateProductStock1
ON OrderDetails
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the product stock based on the inserted order details
    UPDATE Products
    SET stock = stock - inserted.quantity
    FROM Products
    INNER JOIN inserted
    ON Products.product_id = inserted.product_id;

    -- Optionally, check for negative stock levels
    IF EXISTS (SELECT 1 FROM Products WHERE stock < 0)
    BEGIN
        PRINT 'Warning: Stock level for one or more products is negative!';
    END
END;
/*Usage:
Place an order by inserting rows into the OrderDetails table.
The Products table automatically updates its stock for the corresponding product.
This trigger helps maintain inventory accuracy without manual intervention, 
streamlining operations for your grocery store DBMS.*/
select * from OrderDetails
select * from Products 

insert into OrderDetails (order_id,product_id,quantity,price) values (5,3,50,16)


----------------------------------------------------------------------------------------------
/*QUERIES*/


select * from Customers
select * from Orders
select * from OrderDetails
select * from Payments
select * from Categories
select * from Cart
select * from Suppliers
select * from SupplierProducts
select * from Products

/*1.Retrieve all orders placed by customers along with their total amount and 
order status, but only for orders where the total amount exceeds 15rs. 
*/

SELECT C.first_name, C.last_name, O.order_id, O.total_amount, O.status 
FROM Orders O 
JOIN Customers C ON O.customer_id = C.customer_id 
WHERE O.total_amount > 15;
/*2.Find the top 3 most expensive products available in the store and display 
their product name and price. */
SELECT TOP 3
    product_name, price
FROM Products
ORDER BY price DESC;
/*3. List all products from the cart of a particular customer (say customer ID = 1) along
with the quantity added to the cart. */

SELECT P.product_name, C.quantity 
FROM Cart C 
JOIN Products P ON C.product_id = P.product_id 
WHERE C.customer_id = 1; 

/*4. Find how many products are available in each category. */

SELECT c.category_name, COUNT(P.product_id) AS total_products 
FROM Products P 
JOIN Categories c ON P.category_id = c.category_id 
GROUP BY c.category_name;

/*5. Find the customers who have placed orders totaling more than 10rs in 
value across all their orders combined. */
SELECT C.customer_id, C.first_name, C.last_name, SUM(O.total_amount) AS total_spent 
FROM Customers C 
JOIN Orders O ON C.customer_id = O.customer_id 
GROUP BY C.customer_id, C.first_name, C.last_name 
HAVING SUM(O.total_amount) > 10;

/*6.Retrieve all customers who have never placed an order. 
*/
SELECT C.customer_id, C.first_name, C.last_name 
FROM Customers C 
LEFT JOIN Orders O ON C.customer_id = O.customer_id 
WHERE O.order_id IS NULL;


/*7. Get the products that have never been ordered by any customer. 
*/
SELECT P.product_name 
FROM Products P 
LEFT JOIN OrderDetails OD ON P.product_id = OD.product_id 
WHERE OD.product_id IS NULL;

/*8. Find the total revenue generated by each product, ordered from highest 
to lowest revenue.*/
SELECT P.product_name, SUM(OD.quantity * OD.price) AS total_revenue 
FROM OrderDetails OD 
JOIN Products P ON OD.product_id = P.product_id 
GROUP BY P.product_name 
ORDER BY total_revenue DESC; 

/*9. Find the supplier that supplies the most number of different products. 
*/
SELECT TOP 1  S.supplier_name, 
    COUNT(DISTINCT SP.product_id) AS total_products
FROM Suppliers S INNER JOIN 
    SupplierProducts SP ON S.supplier_id = SP.supplier_id
GROUP BY  S.supplier_name
ORDER BY  total_products DESC;

/*10. Retrieve all products along with their categories: 
*/
SELECT P.product_name, C.category_name, P.price, P.stock 
FROM Products P 
JOIN Categories C ON P.category_id = C.category_id; 

/*11. Retrieve all orders for a specific customer: 
*/
SELECT O.order_id, O.order_date, O.total_amount, O.status 
FROM Orders O 
WHERE O.customer_id = 1;
/*12. Find customers who have placed more than 1 orders: 
*/
SELECT C.customer_id, C.first_name, C.last_name, COUNT(O.order_id) AS total_orders 
FROM Customers C 
JOIN Orders O ON C.customer_id = O.customer_id 
GROUP BY C.customer_id, C.first_name, C.last_name 
HAVING COUNT(O.order_id) > 1;

/*13. Update customer email address: 
*/
UPDATE Customers 
SET email = 'ravivarma@gmail.com' 
WHERE customer_id = 2;







-----------------------------------------------------------------------------------------------------------
/*SUB QUERIES*/
/*Find Customers Who Placed the Most Orders*/
SELECT customer_id, first_name, last_name
FROM Customers
WHERE customer_id = (
    SELECT TOP 1 customer_id
    FROM Orders
    GROUP BY customer_id
    ORDER BY COUNT(order_id) DESC
);

/*2.Find Products with Low Stock*/
SELECT product_id, product_name, stock
FROM Products
WHERE stock < (
    SELECT AVG(stock)
    FROM Products
);

/*3.Retrieve the Total Amount Spent by Each Customer*/
SELECT customer_id, 
       (SELECT SUM(total_amount) 
        FROM Orders 
        WHERE Orders.customer_id = Customers.customer_id) AS total_spent
FROM Customers;
/*4.Find Customers Who Have Not Placed Any Orders*/
SELECT customer_id, first_name, last_name
FROM Customers
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM Orders
);

