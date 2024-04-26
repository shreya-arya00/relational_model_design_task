-- Create User table
CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(255) UNIQUE NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    FirstName VARCHAR(100),
    LastName VARCHAR(100)
);

-- Create Product/Service table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- Create Category table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Description TEXT
);

-- Create Cart table
CREATE TABLE Cart (
    CartID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (UserID) REFERENCES User(UserID)  -- Many-To-One/One-To-Many: One user can have many carts
);

-- Create CartItem table
CREATE TABLE CartItem (
    CartItemID INT PRIMARY KEY AUTO_INCREMENT,
    CartID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (CartID) REFERENCES Cart(CartID),  -- Many-To-One/One-To-Many: One cart can have many cart items
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create Order table
CREATE TABLE Order (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    OrderDate DATE,
    TotalPrice DECIMAL(10, 2),
    Status VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES User(UserID)  -- Many-To-One/One-To-Many: One user can have many orders
);

-- Create OrderItem table
CREATE TABLE OrderItem (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Order(OrderID),  -- Many-To-One/One-To-Many: One order can have many order items
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create Review table
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    ProductID INT,
    Rating INT,
    Comment TEXT,
    Date DATE,
    FOREIGN KEY (UserID) REFERENCES User(UserID),  -- Many-To-One/One-To-Many: One user can leave many reviews
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Create PasswordResetToken table
CREATE TABLE PasswordResetToken (
    TokenID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Token VARCHAR(255),
    ExpiryDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES User(UserID)  -- One-To-Many/Many-To-One: One user can have many password reset tokens
);

-- Create ContactMessage table
CREATE TABLE ContactMessage (
    MessageID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Subject VARCHAR(255),
    Content TEXT,
    Date DATETIME,
    FOREIGN KEY (UserID) REFERENCES User(UserID)  -- One-To-Many/Many-To-One: One user can send many contact messages
);

-- Create UserProduct table for Many-To-Many relationship
CREATE TABLE UserProduct (
    UserID INT,
    ProductID INT,
    PRIMARY KEY (UserID, ProductID),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
