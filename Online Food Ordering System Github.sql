create database OnlineFoodOrderingSystem;
use OnlineFoodOrderingSystem;

create table Customers(
	CustomerID int primary key,
    FirstName varchar(50),
    LastName varchar(50),
    Email varchar(100),
    Phone varchar(15),
    RegistrationDate date);
    
create table Restaurants (
	RestaurantID int primary key,
    RestaurantName varchar(100), -- gotta make a spelling change here 
    Address Varchar(200),
    CuisineType varchar(50));
    
create table MenuItems (
	MenuItemID int primary key,
    RestaurantID int ,
    ItemName varchar(100),
    Price Decimal(10,2),
    Description TEXT,
    foreign key (RestaurantID)
    references Restaurants(RestaurantID));
    
    create table Orders (
		OrderID int Primary key,
        CustomerID int,
        RestaurantID int,
        OrderDate date,
        TotalAmount decimal(10,2),
        foreign key (CustomerID)
        references Customers(CustomerID),
        foreign key(RestaurantID)
        references Restaurants(RestaurantID));
        
	create table OrderDetails (
    OrderDetailID int primary key,
    OrderID int,
    MenuItemID int,
    Quantity int,
    ItemPrice Decimal(10,2),

    foreign key (OrderID)
    references Orders(OrderID),

    foreign key (MenuItemID)
    references MenuItems(MenuItemID)
);

create table Reviews (
	ReviewID int primary key,
    RestaurantID int,
    CustomerID int,
    ReviewDate date,
    Rating Decimal(2,1),
    Comments text,
    
    foreign key(RestaurantID)
    references Restaurants(RestaurantID),
    
    foreign key(CustomerID)
    References Customers(CustomerID));
    
INSERT INTO Customers VALUES
(1,'Rahul','Sharma','rahul@gmail.com','9876543210','2024-01-10'),
(2,'Priya','Patel','priya@gmail.com','9876543211','2024-01-15'),
(3,'Amit','Verma','amit@gmail.com','9876543212','2024-02-01'),
(4,'Sneha','Joshi','sneha@gmail.com','9876543213','2024-02-05'),
(5,'Karan','Mehta','karan@gmail.com','9876543214','2024-02-10'),
(6,'Neha','Singh','neha@gmail.com','9876543215','2024-02-15'),
(7,'Rohan','Das','rohan@gmail.com','9876543216','2024-03-01'),
(8,'Anjali','Nair','anjali@gmail.com','9876543217','2024-03-05'),
(9,'Vikas','Yadav','vikas@gmail.com','9876543218','2024-03-10'),
(10,'Pooja','Kulkarni','pooja@gmail.com','9876543219','2024-03-15');

INSERT INTO Restaurants VALUES
(1,'Pizza Palace','Mumbai','Italian'),
(2,'Spicy Hub','Delhi','Indian'),
(3,'Dragon Express','Pune','Chinese'),
(4,'Burger Town','Bangalore','Fast Food'),
(5,'Sushi World','Hyderabad','Japanese'),
(6,'Pasta Point','Chennai','Italian'),
(7,'Taco Fiesta','Goa','Mexican'),
(8,'BBQ Nation','Kolkata','Barbecue'),
(9,'Healthy Bites','Ahmedabad','Healthy'),
(10,'Cafe Aroma','Jaipur','Cafe');

INSERT INTO MenuItems VALUES
(1,1,'Margherita Pizza',18.00,'Cheese Pizza'),
(2,1,'Pepperoni Pizza',22.00,'Pepperoni loaded'),
(3,2,'Butter Chicken',15.00,'Creamy chicken curry'),
(4,2,'Paneer Tikka',12.00,'Grilled paneer'),
(5,3,'Hakka Noodles',10.00,'Chinese noodles'),
(6,4,'Veg Burger',8.00,'Burger with fries'),
(7,5,'Sushi Roll',25.00,'Japanese sushi'),
(8,6,'White Sauce Pasta',16.00,'Creamy pasta'),
(9,7,'Mexican Taco',14.00,'Spicy taco'),
(10,8,'BBQ Chicken',20.00,'Grilled BBQ chicken');

INSERT INTO Orders VALUES
(1,1,1,'2024-04-01',40.00),
(2,2,2,'2024-04-02',35.00),
(3,3,3,'2024-04-03',28.00),
(4,4,4,'2024-04-04',50.00),
(5,5,5,'2024-04-05',60.00),
(6,6,6,'2024-04-06',45.00),
(7,7,7,'2024-04-07',32.00),
(8,8,8,'2024-04-08',55.00),
(9,9,9,'2024-04-09',22.00),
(10,10,10,'2024-04-10',48.00);

INSERT INTO OrderDetails VALUES
(1,1,1,2,18.00),
(2,1,2,1,22.00),
(3,2,3,2,15.00),
(4,3,5,1,10.00),
(5,4,6,3,8.00),
(6,5,7,2,25.00),
(7,6,8,2,16.00),
(8,7,9,2,14.00),
(9,8,10,2,20.00),
(10,9,4,1,12.00);

INSERT INTO Reviews VALUES
(1,1,1,'2024-04-11',4.5,'Great Pizza'),
(2,1,2,'2024-04-12',4.2,'Nice taste'),
(3,1,3,'2024-04-13',4.8,'Excellent'),
(4,2,4,'2024-04-14',3.9,'Good'),
(5,3,5,'2024-04-15',4.1,'Very tasty'),
(6,4,6,'2024-04-16',4.0,'Nice burgers'),
(7,5,7,'2024-04-17',4.7,'Fresh sushi'),
(8,6,8,'2024-04-18',4.3,'Loved pasta'),
(9,7,9,'2024-04-19',3.8,'Good tacos'),
(10,8,10,'2024-04-20',4.6,'Amazing BBQ');

select * from MenuItems where price < 20;
select * from orders where TotalAmount between 30 and 50 and OrderDate Between '2024-01-01' and '2024-12-31';
select * from Restaurants where cuisineType like '%Italian%';
select 
	ItemName,
    Price,
    case	
		when price > 15
        then Price - (price * 0.10)
        else price
        end as DiscountedPrice
	from MenuItems;
    
select *
from Customers
where CustomerID in
(
	select CustomerID
    from Orders
    group by CustomerID
    having sum(totalamount) > 1000);
    
SELECT
    RestaurantID,
    COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY RestaurantID;

Select 
	RestaurantID,
    SUM(TotalAmount) AS TotalSales
from Orders
Group by RestaurantID
having sum(TotalAmount) > 500;

Select
    Restaurants.RestaurantName,
    AVG(Reviews.Rating) AS AverageRating
From Reviews
Inner join Restaurants
ON Reviews.RestaurantID = Restaurants.RestaurantID
Group by Restaurants.RestaurantName
Order by AverageRating DESC
Limit 5;

Select
	Customers.FirstName,
    Customers.LastName,
    Orders.OrderDate,
    Orders.TotalAmount
From Orders
Inner Join Customers
On Orders.CustomerID = Customers.CustomerID;

Select 
	MenuItems.ItemName,
    OrderDetails.Quantity,
    OrderDetails.ItemPrice
From MenuItems
Left Join OrderDetails
On MenuItems.MenuItemID = OrderDetails.MenuItemID;

select
	Restaurants.RestaurantName,
    count(MenuItems.MenuItemID) AS TotalMenuItems
From Restaurants
Inner Join MenuItems
on Restaurants.RestaurantID = MenuItems.RestaurantID
Group by Restaurants.RestaurantName;

Select RestaurantName
from Restaurants
where RestaurantID in
(
	select RestaurantID
    From Reviews
    where Rating > 4.0
    group by RestaurantID
    Having Count(CustomerID) >= 3 );
    
Select 
	MenuItems.ItemName,
    Restaurants.RestaurantName,
    OrderDetails.Quantity,
    OrderDetails.ItemPrice
From OrderDetails
inner join MenuItems
on OrderDetails.MenuItemID = MenuItems.MenuItemID

Inner Join Restaurants
On MenuItems.RestaurantID = Restaurants.RestaurantID;


   
    
    

	
