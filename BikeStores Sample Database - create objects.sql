/*
--------------------------------------------------------------------
© 2017 sqlservertutorial.net All Rights Reserved
--------------------------------------------------------------------
Name   : BikeStores
Link   : http://www.sqlservertutorial.net/load-sample-database/
Version: 1.0
--------------------------------------------------------------------
*/
-- create schemas
CREATE SCHEMA production;


CREATE SCHEMA sales;


-- create tables
CREATE TABLE production.categories (
category_id INT PRIMARY KEY,
category_name VARCHAR (255) NOT NULL
);


CREATE TABLE production.brands (
	brand_id INT PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);

CREATE TABLE production.products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES production.categories (category_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) REFERENCES production.brands (brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE sales.customers (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	street VARCHAR (255),
	city VARCHAR (50),
	state VARCHAR (25),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.stores (
	store_id INT PRIMARY KEY,
	store_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255),
	city VARCHAR (255),
	state VARCHAR (10),
	zip_code VARCHAR (5)
);

CREATE TABLE sales.staffs (
	staff_id INT PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_id INT,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.orders (
	order_id INT PRIMARY KEY,
	customer_id INT,
	order_status tinyint NOT NULL,
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	order_date DATE NOT NULL,
	required_date DATE NOT NULL,
	shipped_date DATE,
	store_id INT NOT NULL,
	staff_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES sales.customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) REFERENCES sales.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE sales.order_items (
	order_id INT,
	item_id INT,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (order_id, item_id),
	FOREIGN KEY (order_id) REFERENCES sales.orders (order_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE production.stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) REFERENCES sales.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES production.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

# production.branch

INSERT INTO production.brands(brand_id,brand_name) VALUES(1,'Electra')
INSERT INTO production.brands(brand_id,brand_name) VALUES(2,'Haro')
INSERT INTO production.brands(brand_id,brand_name) VALUES(3,'Heller')
INSERT INTO production.brands(brand_id,brand_name) VALUES(4,'Pure Cycles')
INSERT INTO production.brands(brand_id,brand_name) VALUES(5,'Ritchey')
INSERT INTO production.brands(brand_id,brand_name) VALUES(6,'Strider')
INSERT INTO production.brands(brand_id,brand_name) VALUES(7,'Sun Bicycles')
INSERT INTO production.brands(brand_id,brand_name) VALUES(8,'Surly')
INSERT INTO production.brands(brand_id,brand_name) VALUES(9,'Trek')

# production.categories

INSERT INTO production.categories(category_id,category_name) VALUES(1,'Children Bicycles')
INSERT INTO production.categories(category_id,category_name) VALUES(2,'Comfort Bicycles')
INSERT INTO production.categories(category_id,category_name) VALUES(3,'Cruisers Bicycles')
INSERT INTO production.categories(category_id,category_name) VALUES(4,'Cyclocross Bicycles')
INSERT INTO production.categories(category_id,category_name) VALUES(5,'Electric Bikes')
INSERT INTO production.categories(category_id,category_name) VALUES(6,'Mountain Bikes')
INSERT INTO production.categories(category_id,category_name) VALUES(7,'Road Bikes')


# production.products

INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(1,'Trek 820 - 2016',9,6,2016,379.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(2,'Ritchey Timberwolf Frameset - 2016',5,6,2016,749.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(3,'Surly Wednesday Frameset - 2016',8,6,2016,999.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(4,'Trek Fuel EX 8 29 - 2016',9,6,2016,2899.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(5,'Heller Shagamaw Frame - 2016',3,6,2016,1320.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(6,'Surly Ice Cream Truck Frameset - 2016',8,6,2016,469.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(7,'Trek Slash 8 27.5 - 2016',9,6,2016,3999.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(8,'Trek Remedy 29 Carbon Frameset - 2016',9,6,2016,1799.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(9,'Trek Conduit+ - 2016',9,5,2016,2999.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(10,'Surly Straggler - 2016',8,4,2016,1549)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(11,'Surly Straggler 650b - 2016',8,4,2016,1680.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(12,'Electra Townie Original 21D - 2016',1,3,2016,549.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(13,'Electra Cruiser 1 (24-Inch) - 2016',1,3,2016,269.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(14,'Electra Girl''s Hawaii 1 (16-inch) - 2015/2016',1,3,2016,269.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(15,'Electra Moto 1 - 2016',1,3,2016,529.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(16,'Electra Townie Original 7D EQ - 2016',1,3,2016,599.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(17,'Pure Cycles Vine 8-Speed - 2016',4,3,2016,429)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(18,'Pure Cycles Western 3-Speed - Women''s - 2015/2016',4,3,2016,449)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(19,'Pure Cycles William 3-Speed - 2016',4,3,2016,449)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(20,'Electra Townie Original 7D EQ - Women''s - 2016',1,3,2016,599.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(21,'Electra Cruiser 1 (24-Inch) - 2016',1,1,2016,269.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(22,'Electra Girl''s Hawaii 1 (16-inch) - 2015/2016',1,1,2016,269.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(23,'Electra Girl''s Hawaii 1 (20-inch) - 2015/2016',1,1,2016,299.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(24,'Electra Townie Original 21D - 2016',1,2,2016,549.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(25,'Electra Townie Original 7D - 2015/2016',1,2,2016,499.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(26,'Electra Townie Original 7D EQ - 2016',1,2,2016,599.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(27,'Surly Big Dummy Frameset - 2017',8,6,2017,999.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(28,'Surly Karate Monkey 27.5+ Frameset - 2017',8,6,2017,2499.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(29,'Trek X-Caliber 8 - 2017',9,6,2017,999.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(30,'Surly Ice Cream Truck Frameset - 2017',8,6,2017,999.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(31,'Surly Wednesday - 2017',8,6,2017,1632.99)
INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(32,'Trek Farley Alloy Frameset - 2017',9,6,2017,469.99)


# sales.customers table

INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(01,'Debra','Burks',NULL,'debra.burks@yahoo.com','9273 Thorne Ave. ','Orchard Park','NY',14127);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(102,'Kasha','Todd',NULL,'kasha.todd@yahoo.com','910 Vine Street ','Campbell','CA',95008);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(103,'Tameka','Fisher',NULL,'tameka.fisher@aol.com','769C Honey Creek St. ','Redondo Beach','CA',90278);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(104,'Daryl','Spence',NULL,'daryl.spence@aol.com','988 Pearl Lane ','Uniondale','NY',11553);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(105,'Charolette','Rice','(916) 381-6003','charolette.rice@msn.com','107 River Dr. ','Sacramento','CA',95820);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(106,'Lyndsey','Bean',NULL,'lyndsey.bean@hotmail.com','769 West Road ','Fairport','NY',14450);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(107,'Latasha','Hays','(716) 986-3359','latasha.hays@hotmail.com','7014 Manor Station Rd. ','Buffalo','NY',14215);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(108,'Jacquline','Duncan',NULL,'jacquline.duncan@yahoo.com','15 Brown St. ','Jackson Heights','NY',11372);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(109,'Genoveva','Baldwin',NULL,'genoveva.baldwin@msn.com','8550 Spruce Drive ','Port Washington','NY',11050);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(110,'Pamelia','Newman',NULL,'pamelia.newman@gmail.com','476 Chestnut Ave. ','Monroe','NY',10950);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(111,'Deshawn','Mendoza',NULL,'deshawn.mendoza@yahoo.com','8790 Cobblestone Street ','Monsey','NY',10952);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(112,'Robby','Sykes','(516) 583-7761','robby.sykes@hotmail.com','486 Rock Maple Street ','Hempstead','NY',11550);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(113,'Lashawn','Ortiz',NULL,'lashawn.ortiz@msn.com','27 Washington Rd. ','Longview','TX',75604);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(114,'Garry','Espinoza',NULL,'garry.espinoza@hotmail.com','7858 Rockaway Court ','Forney','TX',75126);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(115,'Linnie','Branch',NULL,'linnie.branch@gmail.com','314 South Columbia Ave. ','Plattsburgh','NY',12901);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(116,'Emmitt','Sanchez','(212) 945-8823','emmitt.sanchez@hotmail.com','461 Squaw Creek Road ','New York','NY',10002);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(117,'Caren','Stephens',NULL,'caren.stephens@msn.com','914 Brook St. ','Scarsdale','NY',10583);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(118,'Georgetta','Hardin',NULL,'georgetta.hardin@aol.com','474 Chapel Dr. ','Canandaigua','NY',14424);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(119,'Lizzette','Stein',NULL,'lizzette.stein@yahoo.com','19 Green Hill Lane ','Orchard Park','NY',14127);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(120,'Aleta','Shepard',NULL,'aleta.shepard@aol.com','684 Howard St. ','Sugar Land','TX',77478);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(121,'Tobie','Little',NULL,'tobie.little@gmail.com','10 Silver Spear Dr. ','Victoria','TX',77904);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(122,'Adelle','Larsen',NULL,'adelle.larsen@gmail.com','683 West Kirkland Dr. ','East Northport','NY',11731);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(123,'Kaylee','English',NULL,'kaylee.english@msn.com','8786 Fulton Rd. ','Hollis','NY',11423);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(124,'Corene','Wall',NULL,'corene.wall@msn.com','9601 Ocean Rd. ','Atwater','CA',95301);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(125,'Regenia','Vaughan',NULL,'regenia.vaughan@gmail.com','44 Stonybrook Street ','Mahopac','NY',10541);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(126,'Theo','Reese','(562) 215-2907','theo.reese@gmail.com','8755 W. Wild Horse St. ','Long Beach','NY',11561);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(127,'Santos','Valencia',NULL,'santos.valencia@yahoo.com','7479 Carpenter Street ','Sunnyside','NY',11104);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(128,'Jeanice','Frost',NULL,'jeanice.frost@hotmail.com','76 Devon Lane ','Ossining','NY',10562);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(129,'Syreeta','Hendricks',NULL,'syreeta.hendricks@msn.com','193 Spruce Road ','Mahopac','NY',10541);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(130,'Jamaal','Albert',NULL,'jamaal.albert@gmail.com','853 Stonybrook Street ','Torrance','CA',90505);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(131,'Williemae','Holloway','(510) 246-8375','williemae.holloway@msn.com','69 Cypress St. ','Oakland','CA',94603);
INSERT INTO sales.customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code) VALUES(132,'Araceli','Golden',NULL,'araceli.golden@msn.com','12 Ridgeview Ave. ','Fullerton','CA',92831);  


# stores
INSERT INTO sales.stores(store_id, store_name, phone, email, street, city, state, zip_code)
VALUES(205,'Santa Cruz Bikes','(831) 476-4321','santacruz@bikes.shop','3700 Portola Drive', 'Santa Cruz','CA',95060),
      (206,'Baldwin Bikes','(516) 379-8888','baldwin@bikes.shop','4200 Chestnut Lane', 'Baldwin','NY',11432),
      (207,'Rowlett Bikes','(972) 530-5555','rowlett@bikes.shop','8000 Fairway Avenue', 'Rowlett','TX',75088);


# production.stocks

INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(205,1,27);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(206,2,5);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(205,3,6);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(207,4,23);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(205,5,22);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(206,6,0);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(207,7,8);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(207,8,0);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(207,9,11);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(205,10,15);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(206,11,8);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(205,12,16);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(207,13,13);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(206,14,8);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(206,15,3);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(205,16,4);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(207,17,2);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(207,18,16);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(206,19,4);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(206,20,26);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(205,21,24);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(207,22,29);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(206,23,9);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(207,24,10);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(205,25,10);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(205,26,16);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(206,27,21);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(207,28,20);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(206,29,13);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(207,30,30);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(205,31,2);
INSERT INTO production.stocks(store_id, product_id, quantity) VALUES(206,32,10);



# sales.staff

INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(1,'Fabiola','Jackson','fabiola.jackson@bikes.shop','(831) 555-5554',1,207,NULL);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(2,'Mireya','Copeland','mireya.copeland@bikes.shop','(831) 555-5555',1,205,1);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(3,'Genna','Serrano','genna.serrano@bikes.shop','(831) 555-5556',1,207,2);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(4,'Virgie','Wiggins','virgie.wiggins@bikes.shop','(831) 555-5557',1,206,2);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(5,'Jannette','David','jannette.david@bikes.shop','(516) 379-4444',1,206,1);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(6,'Marcelene','Boyer','marcelene.boyer@bikes.shop','(516) 379-4445',1,207,5);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(7,'Venita','Daniel','venita.daniel@bikes.shop','(516) 379-4446',1,207,5);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(8,'Kali','Vargas','kali.vargas@bikes.shop','(972) 530-5555',1,205,1);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(9,'Layla','Terrell','layla.terrell@bikes.shop','(972) 530-5556',1,206,7);
INSERT INTO sales.staffs(staff_id, first_name, last_name, email, phone, active, store_id, manager_id) VALUES(10,'Bernardine','Houston','bernardine.houston@bikes.shop','(972) 530-5557',1,205,7);


# sales.orders

INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(1,01,4,'20160101','20160103','20160103',206,2);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(2,104,4,'20160101','20160104','20160103',206,6);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(3,106,4,'20160102','20160105','20160103',205,7);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(4,109,4,'20160103','20160104','20160105',207,3);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(5,120,4,'20160103','20160106','20160106',206,6);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(6,122,4,'20160104','20160107','20160105',205,5);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(7,125,4,'20160104','20160107','20160105',207,4);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(8,124,4,'20160104','20160105','20160105',206,7);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(9,103,4,'20160105','20160108','20160108',205,1);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(10,110,4,'20160105','20160106','20160106',206,8);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(11,113,4,'20160105','20160108','20160107',207,9);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(12,115,4,'20160106','20160108','20160109',206,10);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(13,119,4,'20160108','20160111','20160111',205,6);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(14,117,4,'20160109','20160111','20160112',205,3);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(15,126,4,'20160109','20160110','20160112',207,9);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(16,132,4,'20160112','20160115','20160115',207,8);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(17,131,4,'20160112','20160114','20160114',206,7);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(18,116,4,'20160114','20160117','20160115',206,3);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(19,108,4,'20160114','20160117','20160116',205,2);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(20,102,4,'20160114','20160116','20160117',207,1);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(21,111,4,'20160115','20160116','20160118',205,5);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(22,114,4,'20160116','20160118','20160117',206,10);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(23,105,4,'20160116','20160119','20160119',205,10);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(24,121,4,'20160118','20160120','20160119',207,9);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(25,123,4,'20160118','20160121','20160121',205,6);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(26,127,4,'20160118','20160121','20160119',206,7);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(27,107,4,'20160119','20160121','20160120',207,7);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(28,130,4,'20160119','20160120','20160121',206,5);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(29,129,4,'20160120','20160122','20160121',205,4);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(30,112,4,'20160120','20160121','20160121',207,4);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(31,128,4,'20160120','20160122','20160122',205,8);
INSERT INTO sales.orders(order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id,staff_id) VALUES(32,118,4,'20160121','20160124','20160122',206,4);


# sales.orders_item
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(1,1,20,1,599.99,0.2);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(4,2,8,2,1799.99,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(3,3,10,2,1549.00,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(10,4,16,2,599.99,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(5,5,4,1,2899.99,0.2);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(7,1,21,1,599.99,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(2,2,15,2,599.99,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(9,1,3,1,999.99,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(11,2,25,1,599.99,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(14,1,2,2,749.99,0.1);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(17,1,11,2,1549.00,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(25,2,17,1,429.00,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(16,3,26,1,599.99,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(12,1,18,1,449.00,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(13,2,12,2,549.99,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(19,3,22,1,599.99,0.1);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(22,4,5,2,999.99,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(26,5,9,2,2999.99,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(27,1,19,1,529.99,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(28,2,6,1,999.99,0.1);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(30,3,13,2,429.00,0.1);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(32,1,28,1,269.99,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(15,2,30,2,599.99,0.07);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(31,1,32,2,3999.99,0.1);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(29,1,31,1,269.99,0.1);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(24,1,27,1,1799.99,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(21,2,23,2,269.99,0.1);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(6,3,29,2,599.99,0.2);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(18,1,14,2,2899.99,0.1);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(23,2,1,1,1680.99,0.05);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(20,1,24,1,269.99,0.1);
INSERT INTO sales.order_items(order_id, item_id, product_id, quantity, list_price,discount) VALUES(8,2,7,2,429.00,0.05);


SELECT * FROM production.brands;
SELECT * FROM production.categories;
SELECT * FROM production.products;
SELECT * FROM production.stocks;
SELECT * FROM sales.customers;
SELECT * FROM sales.stores;
SELECT * FROM sales.staffs;
SELECT * FROM sales.orders;
SELECT * FROM sales.order_items;

# doing the project

SELECT ord.order_id, CONCAT(cus.first_name,'',cus.last_name) AS name,
cus.city,
cus.state,
ord.order_date
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id;

# sales volume and total revenue generated

SELECT ord.order_id, CONCAT(cus.first_name,'',cus.last_name) AS name,
cus.city,
cus.state,
ord.order_date,
SUM(ite.quantity) AS total_units,
SUM(ite.quantity * ite.list_price) AS revenue
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items ite
ON ord.order_id = ite.order_id 
GROUP BY 
ord.order_id, CONCAT(cus.first_name,'',cus.last_name),
cus.city,
cus.state,
ord.order_date;

SELECT ord.order_id, CONCAT(cus.first_name,'',cus.last_name) AS name,
cus.city,
cus.state,
ord.order_date,
SUM(ite.quantity) AS total_units,
SUM(ite.quantity * ite.list_price) AS revenue,
pro.product_name
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items ite
ON ord.order_id = ite.order_id 
JOIN production.products pro
ON ite.product_id =pro.product_id
GROUP BY 
ord.order_id, CONCAT(cus.first_name,'',cus.last_name),
cus.city,
cus.state,
ord.order_date,
pro.product_name;

SELECT ord.order_id, CONCAT(cus.first_name,'',cus.last_name) AS name,
cus.city,
cus.state,
ord.order_date,
SUM(ite.quantity) AS total_units,
SUM(ite.quantity * ite.list_price) AS revenue,
pro.product_name,
cat.category_name
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items ite
ON ord.order_id = ite.order_id 
JOIN production.products pro
ON ite.product_id =pro.product_id
JOIN production.categories cat
ON pro.category_id = cat.category_id
GROUP BY 
ord.order_id, CONCAT(cus.first_name,'',cus.last_name),
cus.city,
cus.state,
ord.order_date,
pro.product_name,
cat.category_name;

SELECT ord.order_id, CONCAT(cus.first_name,'',cus.last_name) AS name,
cus.city,
cus.state,
ord.order_date,
SUM(ite.quantity) AS total_units,
SUM(ite.quantity * ite.list_price) AS revenue,
pro.product_name,
cat.category_name,
sto.store_name
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items ite
ON ord.order_id = ite.order_id 
JOIN production.products pro
ON ite.product_id =pro.product_id
JOIN production.categories cat
ON pro.category_id = cat.category_id
JOIN sales.stores sto
ON ord.store_id = sto.store_id
GROUP BY 
ord.order_id, CONCAT(cus.first_name,'',cus.last_name),
cus.city,
cus.state,
ord.order_date,
pro.product_name,
cat.category_name,
sto.store_name;

SELECT ord.order_id, CONCAT(cus.first_name,'',cus.last_name) AS name,
cus.city,
cus.state,
ord.order_date,
SUM(ite.quantity) AS total_units,
SUM(ite.quantity * ite.list_price) AS revenue,
pro.product_name,
cat.category_name,
sto.store_name,
CONCAT(sta.first_name,'',sta.last_name) AS sales_rep
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items ite
ON ord.order_id = ite.order_id 
JOIN production.products pro
ON ite.product_id =pro.product_id
JOIN production.categories cat
ON pro.category_id = cat.category_id
JOIN sales.stores sto
ON ord.store_id = sto.store_id
JOIN sales.staffs sta
ON ord.staff_id = sta.staff_id
GROUP BY 
ord.order_id, CONCAT(cus.first_name,'',cus.last_name),
cus.city,
cus.state,
ord.order_date,
pro.product_name,
cat.category_name,
sto.store_name,
CONCAT(sta.first_name,'',sta.last_name);
 
