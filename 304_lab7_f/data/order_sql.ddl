DROP TABLE CreditCard;
DROP TABLE PayPal;
DROP TABLE OrderedProduct;
DROP TABLE Shipment;
DROP TABLE Dinosaur;
DROP TABLE JurassicPark;
DROP TABLE Species;
DROP TABLE Orders;
DROP TABLE Review;
DROP TABLE Customer;

CREATE TABLE Customer (
   cid 	INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
   cname 	VARCHAR(30) NOT NULL,
   password VARCHAR(150) NOT NULL,
   address 	VARCHAR(60),
   city 	VARCHAR(30),
   province VARCHAR(30),
   country VARCHAR(30) NOT NULL,
   postalCode 	VARCHAR(10),
   phone 	VARCHAR(11),
   email 	VARCHAR(40) UNIQUE NOT NULL,
   admin BOOLEAN,
   	secQuestion VARCHAR(150) NOT NULL,
	secAnswer VARCHAR(150) NOT NULL
);



CREATE TABLE JurassicPark(
pid INTEGER NOT NULL PRIMARY KEY,
address VARCHAR(50) NOT NULL,
pname VARCHAR(20) NOT NULL
);

CREATE TABLE Species(
speciesName VARCHAR(40) NOT NULL PRIMARY KEY,
speciesDescription VARCHAR(300) NOT NULL,
shrinkageStrength int,
diet VARCHAR(10),
era VARCHAR(10),
handlers int NOT NULL
);

CREATE TABLE Dinosaur (
   	did int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	dname VARCHAR(20) NOT NULL,
	weight int NOT NULL,
	price decimal(10,2) NOT NULL,
	age int NOT NULL,
	gender VARCHAR(6) NOT NULL,
	aboutMe VARCHAR(300),
	picture VARCHAR(100),
	speciesName VARCHAR(40) NOT NULL,
	available boolean NOT NULL,
	pid int NOT NULL,
	FOREIGN KEY(speciesName) REFERENCES Species(speciesName)
	ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(pid) REFERENCES JurassicPark(pid)
	ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE Orders(
orderId INTEGER AUTO_INCREMENT,
customerId INTEGER NOT NULL,
totalPrice INTEGER NOT NULL,
PRIMARY KEY (orderId),
FOREIGN KEY (customerId) REFERENCES Customer(cid)
ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE Shipment(
sid int NOT NULL AUTO_INCREMENT,
did int NOT NULL,
shipDate VARCHAR(10),
height int NOT NULL,
width int NOT NULL,
length int NOT NULL,
shipped BOOLEAN NOT NULL,
PRIMARY KEY (sid),
FOREIGN KEY (did) REFERENCES Dinosaur(did)
ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE CreditCard(
cnum int NOT NULL,
cid int NOT NULL,
expDate char(4) NOT NULL,
ccv int NOT NULL,
ccname VARCHAR(30) NOT NULL,
PRIMARY KEY(cnum,cid),
FOREIGN KEY (cid) REFERENCES Customer(cid)
ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE PayPal(
account int NOT NULL,
cid int NOT NULL,
PRIMARY KEY(account,cid),
FOREIGN KEY (cid) REFERENCES Customer(cid)
ON UPDATE CASCADE ON DELETE NO ACTION
);


CREATE TABLE OrderedProduct (
   orderId       int	NOT NULL,
   did     int	NOT NULL,
   price         decimal(10,2),
   FOREIGN KEY (orderId) REFERENCES Orders (orderId)
   ON UPDATE CASCADE ON DELETE NO ACTION,
   FOREIGN KEY (did) REFERENCES Dinosaur(did)
   ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE Review(
cid int NOT NULL,
text VARCHAR (300),
PRIMARY KEY (cid), 
FOREIGN KEY (cid) REFERENCES Customer(cid)
ON UPDATE CASCADE ON DELETE NO ACTION
);

INSERT INTO Species VALUES('Tyrannosaurus Rex', 'The name Tyrannosaurus rex means King of the Tyrant Lizards. These fantastic beasts had tiny arms but a powerful jaw and tail that could crush their prey.', 4, 'carnivore', 'Cretaceous', 11);
INSERT INTO Species VALUES('Brontosaurus', 'Brontosaurus means Thunder Lizard, and they earn their name with their enormous size. These gentle creatures sretched to the length of 3 school buses!', 5, 'herbivore', 'Jurassic', 2);
INSERT INTO Species VALUES('Plesiosaurus', 'Plesiosaurs are an ocean-dwelling dinosaur with a dolphin-like snout that could snap fish up. They have 4 long flippers that let them fly through the water', 3, 'carnivore', 'Jurassic', 4);
INSERT INTO Species VALUES('Stegosaurus', 'These funky dinosaurs have thick armored plates along their spice, and spikes on their tail for defense. Their brains are only as big as walnuts, but they do not need much brain power to eat shrubs all day!', 2, 'herbivore', 'Jurassic', 3);
INSERT INTO Species VALUES('Velociraptor', 'Velociraptors are not what you would think. About the size of children, they are covered in feathers! Small and agile, they plundered eggs from dino nests', 1, 'carnivore', 'Cretaceous', 2);
INSERT INTO Species VALUES('Pachycephalosaurus', 'These fellas have a crazy name that matches their crazy head-butting tendancies. They have beaks and bald spots', 3, 'herbivore', 'Cretaceous', 4);
INSERT INTO Species VALUES('Suzhousaurus', 'These wacky dinosaurs are something else! Looking more like vultures than anything else, they stand at 6 metres tall!', 2, 'herbivore', 'Cretaceous', 2);

INSERT INTO JurassicPark VALUES(1, '123 Dino Street, Drumheller, AB, Canada', 'Jurassic-Mania');
INSERT INTO JurassicPark VALUES(2, '456 Kraken Road, Keats Island, BC, Canada', 'Marine Dinos');
INSERT INTO JurassicPark VALUES(3, '789 Ancient Lane, Smithers, BC, Canada', 'Cretaceousness');
INSERT INTO JurassicPark VALUES(4, '789 Beast Place, Devlin, ON, Canada', 'Triassical');

INSERT INTO Dinosaur VALUES (1, 'Lisa', 8000, 10000, 5, 'female', 'Lisa is a fun-loving t-rex who has honed her fetching skills to become the Park champion of her favourite game - Dino Egg Toss', 'images/Lisa.png','Tyrannosaurus Rex', true, 3);
INSERT INTO Dinosaur VALUES (2, 'Reggie', 20000, 20000, 3, 'male', 'Reggies favourite activity is rolling around in piles of leaves, so autumn is his favourite season. He also loves cuddles', 'images/Reggie.jpg','Brontosaurus', true, 1);
INSERT INTO Dinosaur VALUES (3, 'Larry', 10, 5000, 3, 'male', 'Larry is a pretty velociraptor. His feathers are his glory so he often spends half the day grooming.', 'images/Larry.jpg','Velociraptor', true, 3);
INSERT INTO Dinosaur VALUES (4, 'Abigail', 650, 20000, 3, 'female', 'Abigail is a bit on the wild side, but she is perfect for active families with young children.', 'images/Abigail.jpg','Stegosaurus', true, 1);
INSERT INTO Dinosaur VALUES (5, 'Derrick', 700, 85000, 11, 'male', 'Derrick is competitive, loves being number one and getting attention, but also has a soft spot for dogs.', 'images/Derrick.jpg','Pachycephalosaurus', true, 3);
INSERT INTO Dinosaur VALUES (6, 'Betty', 600, 6000, 6, 'female', 'Betty is a playful dinosaur but she has a well-developed attitude and likes a good prank.', 'images/Abigail.jpg', 'Suzhousaurus', true, 3);
INSERT INTO Dinosaur VALUES (7, 'Charlie', 3500, 8000, 1, 'Male', 'Charlie is young velociraptor who is always full of energy and ready to play.', 'images/Charlie.jpg','Velociraptor', true, 3);


INSERT INTO Customer (cname, password, address, city, province, country, postalCode, phone, email, secQuestion, secAnswer) VALUES ( 'A. Anderson', 'password1', '103 AnyWhere Street', 'Alabtraz', 'AL','Argentina', '11111' ,'1234567890','aanderson@anywhere.com', 'What was the name of your first pet?', 'Spike');
INSERT INTO Customer (cname, password, address, city, province, country, postalCode, phone, email, secQuestion, secAnswer) VALUES ( 'C. Cole', 'AxBC12', '333 Central Crescent', 'Chicago', 'IL', 'Canada','33333','3334445555','cole@charity.org', 'What is your favourite icecream flavour?', 'Strawberries');
INSERT INTO Customer (cname, password, address, city, province, country, postalCode, phone, email, secQuestion, secAnswer) VALUES ( 'D. Doe', '1234abc', '444 Dover Lane', 'Detroit', 'MI', 'Canada', '44444','4445556666','doe@doe.com', 'What is your favorite color?', 'Blue');
INSERT INTO Customer (cname, password, address, city, province, country, postalCode, phone, email, secQuestion, secAnswer) VALUES ( 'E. Elliott', 'ABCD1245', '555 Everwood Street', 'Engliston', 'IA', 'Canada', '55555' ,'5556667777', 'engel@uiowa.edu', 'What is your favorite food?', 'Pasta');
INSERT INTO Customer (password, cname, address, city, province, country, postalCode, phone, email, admin, secQuestion, secAnswer) VALUES ('admin1', 'Chelsey Hvingelby', '404 Sandstone Place', 'Okotoks', 'AB', 'Canada', 'T1S1P9', '4033363754', 'admin@dino.ca', true, 'What is your favorite food?', 'Pizza');
INSERT INTO Customer (cname, password, address, city, province, country, postalCode, phone, email, admin, secQuestion, secAnswer) VALUES ('Ramon Lawrence', '100Please', '404 House Not Found', 'Kelonwa', 'BC', 'Canada', 'T1L7Y3', '2506784032', 'ramon.lawrence@dino.ca', true, 'What course number do I teach?', '304');

INSERT INTO CreditCard VALUES(12345678, 1, '0518', 123, 'A. Anderson');
INSERT INTO CreditCard VALUES(98765432, 1, '0620', 876, 'A. Anderson');
INSERT INTO PayPal VALUES(98647, 1);

INSERT INTO Review VALUES (1, 'I had an amazing experience while using the website. My dinosaur, Lisa the T-rex, was shipped very fast and in great conditions.');