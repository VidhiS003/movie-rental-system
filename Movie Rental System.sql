CREATE DATABASE MovieRentalDB;
USE MovieRentalDB;

-- Creating the Movies table 
CREATE TABLE Movies (
      MovieID INT PRIMARY KEY AUTO_INCREMENT,
      Title VARCHAR(255) NOT NULL,
      Genre VARCHAR(100),
      RealeaseYear INT,
      RentalPrice DECIMAL(5,2)
);

-- Creating the Customer table 
CREATE TABLE Customers (
       CustomerID INT PRIMARY KEY AUTO_INCREMENT,
       Name VARCHAR(255) NOT NULL,
       Email VARCHAR(255) UNIQUE,
       Phone VARCHAR(15),
	   Address TEXT
);

-- Creating the Rentals table
CREATE TABLE Rentals (
     RentalID INT PRIMARY KEY AUTO_INCREMENT,
     CustomerID INT,
     MovieID INT,
     RentalDate DATE,
     ReturnDate DATE,
     DueDate DATE,
     Returned BOOLEAN DEFAULT FALSE,
     FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), 
     FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) 
);

-- Creating the Payments table
CREATE TABLE Payments (
      PaymentID INT PRIMARY KEY AUTO_INCREMENT,
      RentalID INT,
      Amount DECIMAL(6,2),
      PaymentDate DATE,
      FOREIGN KEY (RentalID) REFERENCES Rentals(RentalID)
);

-- Sample Data Insertion 
INSERT INTO Movies (Title, Genre, RealeaseYear, Rentalprice) VALUES
('Inception', 'Sci-Fi', 2010, 4.99),
('Titanic', 'Romance', 1997, 3.99),
('The Dark Knight', 'Action', 2008, 5.99);

INSERT INTO Customers (Name, Email, Phone, Address) VALUES
('John Doe', 'john@example.com', '1234567890', '123 Elm Street'),
('Jane Smith', 'jane@example.com', '9876543210', '456 Oak Street');

INSERT INTO Rentals (CustomerID, MovieID, RentalDate, DueDate, ReturnDate, Returned ) VALUES
(1, 1, '2024-02-01', '2024-02-05', '2024-02-04', TRUE),
(2, 2, '2024-02-02', '2024-02-06', NULL, FALSE);

INSERT INTO Payments (RentalID, Amount, PaymentDate) VALUES
(1, 4.99, '2024-02-01');

-- Query 1: Most Rented Movies
SELECT m.Title, COUNT(r.RentalId) AS RentalCount
FROM Rentals r 
JOIN Movies m ON r.MovieID = m.MovieID
GROUP BY m.Title
ORDER BY RentalCount DESC;

-- Query 2: Customer Rental History
SELECT c.Name, m.Title, r.RentalDate, r.ReturnDate
FROM Rentals r 
JOIN Customers c ON r.CustomerID = c.CustomerID
JOIN Movies m ON r.MovieId = m.MovieID
ORDER BY c.Name, r.RentalDate;

-- Query 3: Late Returns
SELECT c.Name, m.Title, r.DueDate, r.ReturnDate
FROM Rentals r 
JOIN  Customers c ON r.CustomerID = c.CustomerID
JOIN Movies m ON r.MovieID = m.MovieID
WHERE r.ReturnDate IS NULL OR r.ReturnDate > r.DueDate; 

-- Query 4: Customer
SELECT * 
FROM movierentaldb.customers;
 
 -- Query 5: Movies
SELECT * 
FROM movierentaldb.Movies;
 




