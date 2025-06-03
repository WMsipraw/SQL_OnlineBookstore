-- Customer Table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(100),
    Phone VARCHAR(20),
    Address TEXT
);

-- Book Table
CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(150),
    Author VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

-- Order Table
CREATE TABLE "Order" (
    OrderID INT PRIMARY KEY ,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- OrderDetail Table
CREATE TABLE OrderDetail (
    OrderDetailID INT PRIMARY KEY ,
    OrderID INT,
    BookID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES "Order" (OrderID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

-- Payment Table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY ,
    OrderID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES "Order" (OrderID)
);

-- Insert Customers
INSERT INTO Customer (CustomerID, Name, Email, Password, Phone, Address) VALUES
(1,'Ali Raza', 'ali@example.com', 'ali123', '03001234567', 'Bahawalpur'),
(2,'Ayesha Khan', 'ayesha@example.com', 'ayesha456', '03007654321', 'Multan');

-- Insert Books
INSERT INTO Book (BookID,Title, Author, Category, Price, Stock) VALUES
(1,'Database Systems', 'Elmasri & Navathe', 'Computer Science', 1200.00, 10),
(2,'Clean Code', 'Robert Martin', 'Programming', 1500.00, 5),
(3,'Atomic Habits', 'James Clear', 'Self Help', 900.00, 8);

-- Insert Orders (Assume CustomerID = 1 and 2)
INSERT INTO "Order" (OrderID,CustomerID, OrderDate, TotalAmount) VALUES
(1,1, '2025-06-01', 2700.00),
(2,2, '2025-06-02', 900.00);

-- Insert OrderDetails (Assume OrderID = 1, 2 and BookID = 1, 2, 3)
INSERT INTO OrderDetail (OrderDetailID, OrderID, BookID, Quantity, Price) VALUES
(1,1, 1, 1, 1200.00),
(2,1, 2, 1, 1500.00),
(3,2, 3, 1, 900.00);

-- Insert Payments
INSERT INTO Payment (PaymentID, OrderID, PaymentDate, Amount, PaymentMethod) VALUES
(1,1, '2025-06-01', 2700.00, 'Credit Card'),
(2,2, '2025-06-02', 900.00, 'Cash');

UPDATE Book
SET Price = 1000.00
WHERE BookID = 1;

DELETE FROM OrderDetail
WHERE OrderDetailID = 3;

SELECT c.Name, o.OrderID, o.OrderDate, b.Title, od.Quantity
FROM Customer c
JOIN "Order" o ON c.CustomerID = o.CustomerID
JOIN OrderDetail od ON o.OrderID = od.OrderID
JOIN Book b ON od.BookID = b.BookID;
