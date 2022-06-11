CREATE DATABASE [SEDCWorkShop]

USE [SEDCWorkShop]
------------------------------------------------------------------
******************************************************************
------------------------------------------------------------------
CREATE TABLE [User](
Id int Primary key,
FirstName nvarchar(50),
LastName nvarchar(50),
UserAddress nvarchar(255),
Phone nvarchar(20),
);

CREATE TABLE Pizza(
Id int PRIMARY KEY,
NamePizza nvarchar(50),
Price decimal,
SizeId int,
FOREIGN KEY(SizeId) REFERENCES PizzaSize(Id),
OrderPizza nvarchar(255)
);

CREATE TABLE [Order](
Id int PRIMARY KEY,
UserId int,
FOREIGN KEY(UserId) REFERENCES [User](Id),
IsDelivered bit,
TotalPrice money,
);

CREATE TABLE Topping(
Id int PRIMARY KEY,
NameTopping nvarchar(150),
PriceTopping money,
);

CREATE TABLE PizzaSize(
Id int PRIMARY KEY,
NamePizza nvarchar(1),
);

CREATE TABLE PizzaTopping(
Id int PRIMARY KEY,
PizzaId int FOREIGN KEY (PizzaId) REFERENCES Pizza(Id),
ToppingId int FOREIGN KEY (ToppingId) REFERENCES Topping(Id),
);

CREATE TABLE PizzaOreder(
Id int PRIMARY KEY,
PizzaId int FOREIGN KEY (PizzaId) REFERENCES Pizza(Id),
OrderId int FOREIGN KEY (OrderId) REFERENCES [Order](Id),
);
------------------------------------------------------------------
******************************************************************
------------------------------------------------------------------
GO
CREATE FUNCTION dbo.fn_ConcatNameB(@FirstName nvarchar(50),@LastName nvarchar(50))
RETURNS nvarchar(100)
AS
BEGIN
RETURN CONCAT(@FirstName,@LastName)
END;

SELECT dbo.fn_ConcatNameB('Jovan','Filiposki') 
------------------------------------------------------------------
******************************************************************
------------------------------------------------------------------
GO
CREATE VIEW NotDelivered AS
SELECT po.Id,o.UserId,u.FirstName,u.LastName
FROM [PizzaOreder] po JOIN [Order] o ON po.OrderId=o.Id JOIN  [User] u ON u.Id=o.UserId
WHERE o.IsDelivered=0;

SELECT * FROM NotDelivered
------------------------------------------------------------------
******************************************************************
------------------------------------------------------------------
GO
CREATE PROCEDURE TotalPriceE(@PizzaOrderId INT, @TotalPriceOutput INT OUTPUT)
AS
BEGIN
DECLARE @Toping money;
SET @Toping= (SELECT t.PriceTopping	FROM Topping t	WHERE t.Id=@PizzaOrderId)

DECLARE @PizzaDelivery money;
SET @PizzaDelivery = (SELECT o.TotalPrice	FROM [Order] o	WHERE o.Id=@PizzaOrderId)

DECLARE @PizzaPrice money;
SET @PizzaPrice = (SELECT p.Price	FROM Pizza p	WHERE p.Id=@PizzaOrderId)

SET @TotalPriceOutput = SUM(@PizzaPrice+@Toping+@PizzaDelivery);

END;

DECLARE @priceOut INT;

EXEC TotalPriceE 1, @priceOut OUTPUT;

SELECT @priceOut as TotalPriceOutput
------------------------------------------------------------------
******************************************************************
------------------------------------------------------------------
GO
CREATE OR ALTER VIEW ListPizza(NamePizza,NumberOrders) AS
SELECT p.NamePizza, COUNT(*)
FROM [PizzaOreder] po JOIN [Order] o ON o.Id=po.OrderId JOIN [Pizza] p ON po.PizzaId=p.Id
GROUP BY p.NamePizza

SELECT TOP 1 * FROM ListPizza ORDER BY NumberOrders DESC
------------------------------------------------------------------
******************************************************************
------------------------------------------------------------------
GO 
CREATE OR ALTER VIEW ListTopping(Topoing,NumberOfAdded) AS 
SELECT t.NameTopping, COUNT(*)
FROM [PizzaTopping] pt JOIN [Topping] t ON t.Id=pt.ToppingId JOIN [Pizza] p ON p.Id=pt.PizzaId
GROUP BY t.NameTopping

SELECT * FROM ListTopping ORDER BY NumberOfAdded DESC
------------------------------------------------------------------
******************************************************************
------------------------------------------------------------------
GO 
CREATE OR ALTER VIEW UserOrders(NameOfUser,NumberOfOrders) AS 
SELECT u.Id, COUNT(o.Id)
FROM [Order] o JOIN [User] u ON u.Id=o.UserId
GROUP BY u.Id

SELECT * FROM UserOrders ORDER BY NumberOfOrders DESC
------------------------------------------------------------------
******************************************************************
------------------------------------------------------------------
INSERT INTO [User] VALUES (1, 'User1', 'LUser1', 'Address1', '1111111111111');

INSERT INTO [User] VALUES (2, 'User2', 'LUser2', 'Address2', '1111111111112');

INSERT INTO [User] VALUES (3, 'User3', 'LUser3', 'Address3', '1111111111113');

INSERT INTO [User] VALUES (4, 'User4', 'LUser4', 'Address4', '1111111111114');

INSERT INTO [User] VALUES (5, 'User5', 'LUser5', 'Address5', '1111111111115');

INSERT INTO [User] VALUES (6, 'User6', 'LUser6', 'Address6', '1111111111116');

INSERT INTO [User] VALUES (7, 'User7', 'LUser7', 'Address7', '1111111111117');

INSERT INTO [User] VALUES (8, 'User8', 'LUser8', 'Address8', '1111111111118');

INSERT INTO [User] VALUES (9, 'User9', 'LUser9', 'Address9', '1111111111119');

INSERT INTO [User] VALUES (10, 'User10', 'LUser10', 'Address10', '1111111111110');

INSERT INTO [User] VALUES (11, 'User11', 'LUser11', 'Address11', '11111111111111');

INSERT INTO [User] VALUES (12, 'User12', 'LUser12', 'Address12', '11111111111112');

INSERT INTO [User] VALUES (13, 'User13', 'LUser13', 'Address13', '11111111111113');

INSERT INTO [User] VALUES (14, 'User14', 'LUser14', 'Address14', '11111111111114');

INSERT INTO [User] VALUES (15, 'User15', 'LUser15', 'Address15', '11111111111115');

INSERT INTO [User] VALUES (16, 'User16', 'LUser16', 'Address16', '11111111111116');

 

INSERT INTO [Pizza] VALUES (1, 'Pizza1', 1, 1,'haha');

INSERT INTO [Pizza] VALUES (2, 'Pizza2', 2, 1,'haha');

INSERT INTO [Pizza] VALUES (3, 'Pizza3', 3, 2,'haha');

INSERT INTO [Pizza] VALUES (4, 'Pizza4', 4, 2,'haha');

INSERT INTO [Pizza] VALUES (5, 'Pizza5', 5, 1,'haha');

INSERT INTO [Pizza] VALUES (6, 'Pizza6', 6, 1,'haha');

INSERT INTO [Pizza] VALUES (7, 'Pizza7', 7, 3,'haha');

INSERT INTO [Pizza] VALUES (8, 'Pizza8', 8, 3,'haha');

INSERT INTO [Pizza] VALUES (9, 'Pizza9', 9, 3,'haha');

 

INSERT INTO [PizzaSize] VALUES (1, 'S');

INSERT INTO [PizzaSize] VALUES (2, 'M');

INSERT INTO [PizzaSize] VALUES (3, 'L');

 

INSERT INTO [Order] VALUES (1, 1, 1, 10020);

INSERT INTO [Order] VALUES (2, 2, 1, 10100);

INSERT INTO [Order] VALUES (3, 3, 0, 10700);

INSERT INTO [Order] VALUES (4, 4, 0, 1000);

INSERT INTO [Order] VALUES (5, 5, 1, 10600);

INSERT INTO [Order] VALUES (6, 6, 1, 1000);

INSERT INTO [Order] VALUES (7, 7, 0, 16000);

INSERT INTO [Order] VALUES (8, 8, 1, 15000);

INSERT INTO [Order] VALUES (9, 9, 0, 1000);

INSERT INTO [Order] VALUES (10, 10, 0, 1000);

INSERT INTO [Order] VALUES (11, 1, 1, 41000);

INSERT INTO [Order] VALUES (12, 2, 1, 1000);

INSERT INTO [Order] VALUES (13, 3, 1, 1000);

INSERT INTO [Order] VALUES (14, 4, 1, 12000);

INSERT INTO [Order] VALUES (15, 5, 0, 1000);

INSERT INTO [Order] VALUES (16, 6, 0, 11000);

INSERT INTO [Order] VALUES (17, 7, 1, 11000);

INSERT INTO [Order] VALUES (18, 8, 1, 19000);

INSERT INTO [Order] VALUES (19, 9, 1, 19000);

INSERT INTO [Order] VALUES (20, 10, 1, 81000);

INSERT INTO [Order] VALUES (21, 1, 1, 17000);

INSERT INTO [Order] VALUES (22, 2, 1, 16000);

INSERT INTO [Order] VALUES (23, 3, 1, 15000);

INSERT INTO [Order] VALUES (24, 4, 1, 14000);

INSERT INTO [Order] VALUES (25, 5, 1, 13000);

INSERT INTO [Order] VALUES (26, 6, 1, 12000);

INSERT INTO [Order] VALUES (27, 7, 1, 11000);

INSERT INTO [Order] VALUES (28, 8, 0, 10000);

INSERT INTO [Order] VALUES (29, 9, 0, 9000);

INSERT INTO [Order] VALUES (30, 10, 1, 8000);

INSERT INTO [Order] VALUES (31, 1, 1, 7000);

INSERT INTO [Order] VALUES (32, 2, 1, 6000);

INSERT INTO [Order] VALUES (33, 3, 0, 5000);

INSERT INTO [Order] VALUES (34, 4, 0, 4000);

INSERT INTO [Order] VALUES (35, 5, 0, 3000);

INSERT INTO [Order] VALUES (36, 6, 1, 2000);

INSERT INTO [Order] VALUES (37, 7, 1, 1000);

 

INSERT INTO [Topping] VALUES (1, 'Topping1', 10);

INSERT INTO [Topping] VALUES (2, 'Topping2', 20);

INSERT INTO [Topping] VALUES (3, 'Topping3', 30);

INSERT INTO [Topping] VALUES (4, 'Topping4', 40);

INSERT INTO [Topping] VALUES (5, 'Topping5', 50);

INSERT INTO [Topping] VALUES (6, 'Topping6', 60);

INSERT INTO [Topping] VALUES (7, 'Topping7', 70);

INSERT INTO [Topping] VALUES (8, 'Topping8', 80);

INSERT INTO [Topping] VALUES (9, 'Topping9', 90);

INSERT INTO [Topping] VALUES (10, 'Topping10', 100);

INSERT INTO [Topping] VALUES (11, 'Topping11', 110);

INSERT INTO [Topping] VALUES (12, 'Topping12', 120);

 

INSERT INTO [PizzaOreder] VALUES (1, 1, 1);

INSERT INTO [PizzaOreder] VALUES (2, 2, 2);

INSERT INTO [PizzaOreder] VALUES (3, 2, 3);

INSERT INTO [PizzaOreder] VALUES (4, 3, 4);

INSERT INTO [PizzaOreder] VALUES (5, 4, 5);

INSERT INTO [PizzaOreder] VALUES (6, 5, 6);

INSERT INTO [PizzaOreder] VALUES (7, 6, 7);

INSERT INTO [PizzaOreder] VALUES (8, 7, 8);

INSERT INTO [PizzaOreder] VALUES (9, 8, 9);

INSERT INTO [PizzaOreder] VALUES (10, 9, 10);

INSERT INTO [PizzaOreder] VALUES (11, 1, 11);

INSERT INTO [PizzaOreder] VALUES (12, 2, 12);

INSERT INTO [PizzaOreder] VALUES (13, 3, 13);

INSERT INTO [PizzaOreder] VALUES (14, 4, 14);

INSERT INTO [PizzaOreder] VALUES (15, 5, 15);

INSERT INTO [PizzaOreder] VALUES (16, 6, 16);

INSERT INTO [PizzaOreder] VALUES (17, 7, 17);

INSERT INTO [PizzaOreder] VALUES (18, 8, 18);

INSERT INTO [PizzaOreder] VALUES (19, 9, 19);



INSERT INTO [PizzaTopping] VALUES (1,1,1);

INSERT INTO [PizzaTopping] VALUES (2,2,1);

INSERT INTO [PizzaTopping] VALUES (3,3,2);

INSERT INTO [PizzaTopping] VALUES (4,1,3);

INSERT INTO [PizzaTopping] VALUES (5,4,5);

INSERT INTO [PizzaTopping] VALUES (6,5,6);

INSERT INTO [PizzaTopping] VALUES (8,6,4);

INSERT INTO [PizzaTopping] VALUES (7,5,5);
------------------------------------------------------------------
******************************************************************
------------------------------------------------------------------