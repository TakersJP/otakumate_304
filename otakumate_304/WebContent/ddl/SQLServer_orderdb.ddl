CREATE DATABASE orders;
go

USE orders;
go

DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(200),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Mangas');
INSERT INTO category(categoryName) VALUES ('Video Games');
INSERT INTO category(categoryName) VALUES ('TCGs');
INSERT INTO category(categoryName) VALUES ('Figures');


INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Oshi No Ko (Volume 1)', 1, 'Oshi No Ko, Manga, Volume 1',10.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Oshi No Ko (Volume 2)', 1, 'Oshi No Ko, Manga, Volume 2',10.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Oshi No Ko (Volume 3)', 1, 'Oshi No Ko, Manga, Volume 3',10.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Oshi No Ko (Volume 4)', 1, 'Oshi No Ko, Manga, Volume 4',10.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Oshi No Ko (Volume 4)', 1, 'Oshi No Ko, Manga, Volume 5',10.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Oshi No Ko (Volume 6)', 1, 'Oshi No Ko, Manga, Volume 6',10.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Oshi No Ko (Volume 7)', 1, 'Oshi No Ko, Manga, Volume 7',10.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Oshi No Ko (Volume 8)', 1, 'Oshi No Ko, Manga, Volume 8',10.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Oshi No Ko (Volume 9)', 1, 'Oshi No Ko, Manga, Volume 9',10.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Oshi No Ko (Volume 10)', 1, 'Oshi No Ko, Manga, Volume 10',10.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dragon Ball Super (Volume 1)', 1, 'Dragon Ball Super, Volume 1',8.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dragon Ball Super (Volume 2)', 1, 'Dragon Ball Super, Volume 2',8.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dragon Ball Super (Volume 3)', 1, 'Dragon Ball Super, Volume 3',8.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dragon Ball Super (Volume 4)', 1, 'Dragon Ball Super, Volume 4',8.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dragon Ball Super (Volume 5)', 1, 'Dragon Ball Super, Volume 5',8.50);

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Pokémon Scarlet', 2, 'Pokémon Scarlet, Nintendo Switch Software',77.95);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Pokémon Violet', 2, 'Pokémon Violet, Nintendo Switch Software',77.95);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Pokémon Legends: Arceus', 2, 'Pokémon Legends: Arceus, Nintendo Switch Software',77.95);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mario Kart 8 Deluxe', 2, 'Mario Kart 8 Deluxe, Nintendo Switch Software',72.95);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Super Mario Party', 2, 'Super Mario Party, Nintendo Switch Software',80.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Super Smash Bros. Ultimate', 2, 'Super Smash Bros. Ultimate, Nintendo Switch Software',78.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Demon Slayer: The Hinokami Chronicles', 2, 'Demon Slayer: The Hinokami Chronicles, PS5 Software',65.10);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Persona 5 Royal', 2, 'Persona 5 Royal, PS5 Software',45.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dragon Ball: Sparking! Zero', 2, 'Dragon Ball: Sparking! Zero, PS5 Software', 90.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('ONE PIECE ODYSSEY', 2, 'ONE PIECE ODYSSEY, PS5 Software', 29.95);

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sword & Shield-Silver Tempest Booster Display Box (36 Packs)', 3, 'Pokémon TCG', 186.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Scarlet & Violet-Twilight Masquerade Booster Display Box (36 Packs)', 3, 'Pokémon TCG', 210.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Scarlet & Violet-Obsidian Flames Booster Display Box (36 Packs)', 3, 'Pokémon TCG', 210.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sword & Shield-Vivid Voltage Booster Display Box (36 Packs)', 3, 'Pokémon TCG', 186.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Scarlet & Violet-Twilight Masquerade Booster Bundle (6 Packs)', 3, 'Pokémon TCG', 35.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Magic The Gathering: Lord of The Rings: Tales of Middle-Earth Set Booster Pack', 3, 'MTG', 29.90);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Magic: The Gathering Fallout Commander Deck – Mutant Menace (100-Card Deck, 2-Card Collector Booster Sample Pack + Accessories)', 3, 'MTG', 114.58);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Magic: The Gathering Duskmourn: House of Horror Collector Booster', 3, 'MTG', 52.95);


INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Luffy', 4, 'One Piece Figure', 21.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mitsuri Kanroji', 4, 'Demon Slayer Figure', 22.12);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Goku', 4, 'Dragon Ball Z Figure', 19.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gojo', 4, 'Jujutsu Kaisen Figure', 25.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ai Hoshino', 4, 'Oshi No Ko Figure', 19.95);








INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 10.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 10.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 10.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 10.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 10.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 10.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 1, 10.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 10.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 10.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (11, 1, 5, 8.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (12, 1, 6, 8.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (13, 1, 3, 8.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (14, 1, 1, 8.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (15, 1, 3, 8.50);

INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (16, 1, 2, 77.95);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (17, 1, 5, 77.95);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (18, 1, 1, 77.95);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (19, 1, 2, 72.95);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (20, 1, 6, 80.0);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (21, 1, 2, 78.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (22, 1, 7, 65.10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (23, 1, 10, 45.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (24, 1, 8, 90.00);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (25, 1, 15, 29.95);

INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (26, 1, 1, 186.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (27, 1, 1, 210.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (28, 1, 1, 210.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (29, 1, 2, 186.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (30, 1, 1, 35.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (31, 1, 2, 29.90);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (32, 1, 2, 114.58);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (33, 1, 2, 52.95);

INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (34, 1, 2, 21.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (35, 1, 2, 22.12);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (36, 1, 1, 19.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (37, 1, 5, 25.99);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (38, 1, 4, 19.95);


INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Takumi', 'Choi', 'takumichoi@gmail.com', '250-324-3284', '422 Academy Way', 'Kelowna', 'BC', 'V1V XX1', 'Canada', 'takersjp' , 'takumi');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Jaiden', 'Lo', 'jaidenlo@gmail.com', '243-378-9830', '784 Academy Way', 'Kelowna', 'BC', 'V1V YS3', 'Canada', 'slimo' , 'jaiden');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , '304Arnold!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , '304Bobby!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , '304Candace!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , '304Darren!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , '304Beth!');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Lebron', 'James', 'lebron@gmail.com', '253-439-3881', '133 Academy Way', 'Kelowna', 'BC', 'V1V X5X', 'Canada', 'lebron' , 'james');

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2024-12-01 10:25:55', 168.45)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 2, 1, 10.50)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 1, 80.00)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 17, 1, 77.95);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2024-12-01 18:00:00', 80.00)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 1, 80.00);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2024-12-02 3:30:22', 43.98)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 31, 2, 29.00)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 34, 2, 43.98);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2024-12-03 05:45:11', 29.50)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 1, 10.50)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 1, 10.50)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 1, 8.50)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 1, 210.99)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 1, 186.99);

INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2024-12-03 10:25:55', 172.90)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 38, 1, 19.95)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 1, 72.95)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 1, 80.00);

UPDATE Product SET productImageURL = 'img/item_1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/item_2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/item_3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/item_4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/item_5.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/item_6.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/item_7.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/item_8.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/item_9.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/item_10.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/item_11.jpg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/item_12.jpg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/item_13.jpg' WHERE ProductId = 13;
UPDATE Product SET productImageURL = 'img/item_14.jpg' WHERE ProductId = 14;
UPDATE Product SET productImageURL = 'img/item_15.jpg' WHERE ProductId = 15;
UPDATE Product SET productImageURL = 'img/item_16.jpg' WHERE ProductId = 16;
UPDATE Product SET productImageURL = 'img/item_17.jpg' WHERE ProductId = 17;
UPDATE Product SET productImageURL = 'img/item_18.jpg' WHERE ProductId = 18;
UPDATE Product SET productImageURL = 'img/item_19.jpg' WHERE ProductId = 19;
UPDATE Product SET productImageURL = 'img/item_20.jpg' WHERE ProductId = 20;
UPDATE Product SET productImageURL = 'img/item_21.jpg' WHERE ProductId = 21;
UPDATE Product SET productImageURL = 'img/item_22.jpg' WHERE ProductId = 22;
UPDATE Product SET productImageURL = 'img/item_23.jpg' WHERE ProductId = 23;
UPDATE Product SET productImageURL = 'img/item_24.jpg' WHERE ProductId = 24;
UPDATE Product SET productImageURL = 'img/item_25.jpg' WHERE ProductId = 25;
UPDATE Product SET productImageURL = 'img/item_26.jpg' WHERE ProductId = 26;
UPDATE Product SET productImageURL = 'img/item_27.jpg' WHERE ProductId = 27;
UPDATE Product SET productImageURL = 'img/item_28.jpg' WHERE ProductId = 28;
UPDATE Product SET productImageURL = 'img/item_29.jpg' WHERE ProductId = 29;
UPDATE Product SET productImageURL = 'img/item_30.jpg' WHERE ProductId = 30;
UPDATE Product SET productImageURL = 'img/item_31.jpg' WHERE ProductId = 31;
UPDATE Product SET productImageURL = 'img/item_32.jpg' WHERE ProductId = 32;
UPDATE Product SET productImageURL = 'img/item_33.jpg' WHERE ProductId = 33;
UPDATE Product SET productImageURL = 'img/item_34.jpg' WHERE ProductId = 34;
UPDATE Product SET productImageURL = 'img/item_35.jpg' WHERE ProductId = 35;
UPDATE Product SET productImageURL = 'img/item_36.jpg' WHERE ProductId = 36;
UPDATE Product SET productImageURL = 'img/item_37.jpg' WHERE ProductId = 37;
UPDATE Product SET productImageURL = 'img/item_38.jpg' WHERE ProductId = 38;