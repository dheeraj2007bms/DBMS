
DROP DATABASE IF EXISTS bank;
CREATE DATABASE bank;
USE bank;



CREATE TABLE Branch (
    branchname VARCHAR(30) PRIMARY KEY,
    branchcity VARCHAR(20),
    assets INT
);

CREATE TABLE BankAccount (
    accno INT PRIMARY KEY,
    branchname VARCHAR(30),
    balance INT,
    FOREIGN KEY (branchname) REFERENCES Branch(branchname)
);

CREATE TABLE BankCustomer (
    customername VARCHAR(20) PRIMARY KEY,
    customerstreet VARCHAR(30),
    customercity VARCHAR(20)
);

CREATE TABLE Depositor (
    customername VARCHAR(20),
    accno INT,
    PRIMARY KEY (customername, accno),
    FOREIGN KEY (customername) REFERENCES BankCustomer(customername),
    FOREIGN KEY (accno) REFERENCES BankAccount(accno)
);

CREATE TABLE Loan (
    loannumber INT PRIMARY KEY,
    branchname VARCHAR(30),
    amount INT,
    FOREIGN KEY (branchname) REFERENCES Branch(branchname)
);

-- Insert Data

INSERT INTO Branch VALUES
('SBI_Chamrajpet', 'Bngalore', 50000),
('SBI_ResidencyRoad', 'Banglore', 10000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParlimentRoad', 'Delhi', 10000),
('SBI_Jantarmantar', 'Delhi', 20000);

INSERT INTO BankAccount VALUES
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000),
(4, 'SBI_ParlimentRoad', 9000),
(5, 'SBI_Jantarmantar', 8000),
(6, 'SBI_ShivajiRoad', 4000),
(8, 'SBI_ResidencyRoad', 4000),
(9, 'SBI_PrlimentRoad', 3000),
(10, 'SBI_ResidencyRoad', 5000),
(11, 'SBI_Jantarmantar', 2000);

INSERT INTO BankCustomer VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bnnergatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');

INSERT INTO Depositor VALUES
('Avinash', 1),
('Dinesh', 2),
('Nikil', 4),
('Ravi', 5),
('Avinash', 8),
('Nikil', 9),
('Dinesh', 10),
('Nikil', 11);

INSERT INTO Loan VALUES
(1, 'SBI_Chamrajpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_ParlimentRoad', 4000),
(5, 'SBI_Jantarmantar', 5000);


SELECT branchname, assets / 100000 AS "Assets in Lakhs"
FROM Branch;


SELECT d.customername, b.branchname, COUNT(*) AS "Number of Accounts"
FROM Depositor d
JOIN BankAccount ba ON d.accno = ba.accno
JOIN Branch b ON ba.branchname = b.branchname
GROUP BY d.customername, b.branchname
HAVING COUNT(*) >= 2;


CREATE VIEW bank_loan AS
SELECT branchname, SUM(amount) AS total_amount
FROM Loan
GROUP BY branchname;

SELECT * FROM bank_loan;
