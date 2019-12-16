/* Create an entity named 'book' */
CREATE TABLE book
	(title varchar2 (50)
    		CONSTRAINT title_null NOT NULL,
	Publisher varchar2 (50)
    		CONSTRAINT pub_null NOT NULL,
	Year date
    		CONSTRAINT year_null NOT NULL,
	ISBN number (13)
    		CONSTRAINT isbn_pk PRIMARY KEY);

/* Insert information into the book entity */ 
INSERT INTO book
	VALUES (q'#Lily’s Book#', 'NYC Publishing', to_date(2007, 'yyyy'), 4569871236543);
INSERT INTO book
	VALUES ('The Three Pigs', 'HarperCollins', to_date(2005, 'yyyy'), 7329871292541);
INSERT INTO book
	VALUES (q'#Jessica’s Adventures#', 'MacMillan', to_date(2013, 'yyyy'), 9836821956243);
INSERT INTO book
	VALUES ('Nancy Drew', 'Wanderer Books', to_date(2003, 'yyyy'), 8215409823467);
INSERT INTO book
	VALUES ('Moby Dick', 'HarperCollins', to_date(2002, 'yyyy'),7390458192345);


/* Create the author enitity to hold information about authors using ISBN from book as a foreign key */
CREATE TABLE author
	(author varchar2 (50),
	ISBN number (13),
	CONSTRAINT isbn_fk FOREIGN KEY(isbn)
    	REFERENCES book(isbn),
	CONSTRAINT author_isbn_pk PRIMARY KEY (ISBN, author));

/* Insert information about authors into the author entity */ 
INSERT INTO author
	VALUES ('Lily Kelman',4569871236543);
INSERT INTO author
	VALUES ('John Wayne', 7329871292541);
INSERT INTO author
	VALUES ('John Teifel', 7329871292541);
INSERT INTO author
	VALUES ( 'Jessica MacMillan', 9836821956243);
INSERT INTO author
	VALUES ('Carolyn Keene', 8215409823467);
INSERT INTO author
	VALUES ('Herman Melville', 7390458192345);


/* Create the store entity to store information about each store location */
CREATE TABLE store
	(storeID number
	CONSTRAINT stID_pk PRIMARY KEY,
	Street_address varchar2 (50)
    	CONSTRAINT sa2_null NOT NULL,
	City varchar2 (50)
    	CONSTRAINT cit_null NOT NULL,
	state varchar2 (2)
    	CONSTRAINT stat_null NOT NULL,
	zip_code number (5)
    	CONSTRAINT zc2_null NOT NULL);

/* Insert the store information into the entity */
INSERT INTO store
	VALUES(4000001, '3146 San Miguel Ave', 'Morgan Hill', 'CA', '93405'); 
INSERT INTO store
	VALUES(4000002, '713 Mustang Drive', 'Milpitas', 'GA', '82340'); 
INSERT INTO store
	VALUES(4000003, '1032 Broad Street', 'Indianappolis', 'IN', '33045'); 
INSERT INTO store
	VALUES(4000004, '780 Encino Dr', 'Irvine', 'NJ', '94603'); 
INSERT INTO store
	VALUES(4000005, '532 Sierra Seco Dr', 'Costa Mesa', 'VA', '92686'); 


/* Create the store inventory entity */ 
CREATE TABLE store_inventory
	(ISBN number(13),
	storeID number,
	Quantity number
    	CONSTRAINT quant_null NOT NULL,
    	CONSTRAINT isbn4_fk FOREIGN KEY(isbn)
	REFERENCES book(ISBN),
CONSTRAINT stor_fk FOREIGN KEY(storeID)
    	REFERENCES store(storeID),
CONSTRAINT store_comp_primary PRIMARY KEY(isbn, storeID));

/* insert inventory information for the stores */ 
INSERT INTO store_inventory
VALUES(7390458192345, 4000001, 45);
INSERT INTO store_inventory
VALUES(4569871236543, 4000001, 22);
INSERT INTO store_inventory
VALUES(7329871292541, 4000002, 10);
INSERT INTO store_inventory
VALUES(9836821956243, 4000003, 8);
INSERT INTO store_inventory
VALUES(8215409823467, 4000003, 15);
INSERT INTO store_inventory
VALUES(7390458192345, 4000003, 13);
INSERT INTO store_inventory
VALUES(4569871236543, 4000004, 26);
INSERT INTO store_inventory
VALUES(7329871292541, 4000004, 32);
INSERT INTO store_inventory
VALUES(9836821956243, 4000005, 7);
INSERT INTO store_inventory
VALUES(8215409823467, 4000005, 15);
INSERT INTO store_inventory
VALUES(7390458192345, 4000005, 22);
INSERT INTO store_inventory
VALUES(7329871292541, 4000005, 83);
INSERT INTO store_inventory
VALUES(7329871292541, 4000003, 83);


/* create the customer entity */ 
CREATE TABLE customer
	(customerID number
    	CONSTRAINT custID_pk PRIMARY KEY,
	First_name varchar2 (50)
    	CONSTRAINT fn_null NOT NULL,
	last_name varchar2 (50)
    	CONSTRAINT ln_null NOT NULL,
	Email varchar2 (50)
    	CONSTRAINT email_un UNIQUE,
	Phone_number number (10));

/* fill the customer table with values for each customer of the stores */ 
INSERT INTO customer
VALUES(8000001, 'Trey', 'Chambers', 'tchamber@gmail.com', 7146825411);
INSERT INTO customer
VALUES(8000002, 'Nicole', 'Poirier', 'npoirier@gmail.com', 8584496595);
INSERT INTO customer
VALUES(8000003, 'Peter', 'Alden', 'palden@gmail.com', 949613191);
INSERT INTO customer
VALUES(8000004, 'Rebecca', 'Bland', 'rbland@gmail.com', 8054336752);
INSERT INTO customer
VALUES(8000005, 'Michael', 'Klee', 'mklee@gmail.com', 7072286300);


/* create the payment entity to log customer credit cards */ 
CREATE TABLE payment
	(credit_card number
    	CONSTRAINT ccc_null NOT NULL,
	customerID number,
	CONSTRAINT customerID_fk FOREIGN KEY (customerID)
    	REFERENCES customer(customerID),
CONSTRAINT cust_ccc_pk PRIMARY KEY(customerID, credit_card));

/* populate the payment table with the information about each credit card and customer */ 
INSERT INTO payment
VALUES(3345220288311345, 8000001);
INSERT INTO payment
VALUES(8342746301372837, 8000001);
INSERT INTO payment
VALUES(2847635520912542, 8000004);
INSERT INTO payment
VALUES(7462946323927645, 8000002);
INSERT INTO payment
VALUES(3214584301938472, 8000003);


TRANSACTION
CREATE TABLE transaction
	(transactionID number
    	CONSTRAINT tid_pk PRIMARY KEY,
	transaction_date date
    	CONSTRAINT td_null NOT NULL,
	Credit_card number(16)
    	CONSTRAINT cc_null NOT NULL,
	Sale number
    	CONSTRAINT sale_round CHECK ( Sale=ROUND(Sale, 2))
    	CONSTRAINT sale_null NOT NULL,
	storeID number
    	CONSTRAINT stoid_null NOT NULL,
	CONSTRAINT stot_fk FOREIGN KEY (storeID)
	REFERENCES store(storeID),
	customerID number
    	CONSTRAINT cid_null NOT NULL,
CONSTRAINT ctid_fk FOREIGN KEY (customerID)
	REFERENCES customer(customerID));

INSERT INTO transaction
VALUES(7000001, to_date('06-08-2019', 'mm-dd-yyyy'), 3345220288311345, 12.95, 4000004, 8000001);
INSERT INTO transaction 
VALUES(7000002, to_date('06-08-2019', 'mm-dd-yyyy'), 3214584301938472, 55.04, 4000003, 8000003);
INSERT INTO transaction 
VALUES(7000003, to_date('06-09-2019', 'mm-dd-yyyy'), 7462946323927645, 25.90, 4000003, 8000002);
INSERT INTO transaction 
VALUES(7000004, to_date('06-12-2019', 'mm-dd-yyyy'), 2847635520912542, 12.41, 4000001, 8000004);
INSERT INTO transaction 
VALUES(7000005, to_date('06-16-2019', 'mm-dd-yyyy'), 8342746301372837, 83.10, 4000003, 8000001);

TRANSACTION LINE
CREATE TABLE transaction_line
	(quantity number
    	CONSTRAINT q_null NOT NULL,
	ISBN number(13)
    	CONSTRAINT isbn_null NOT NULL,
	Price_per_unit number
    	CONSTRAINT unit_price_round CHECK ( Price_Per_Unit=ROUND(Price_Per_Unit, 2))
    	CONSTRAINT price_null NOT NULL,
	transactionID number,
    	CONSTRAINT isbn2_fk FOREIGN KEY(ISBN)
    	REFERENCES book(ISBN),
    	CONSTRAINT tid_fk FOREIGN KEY(transactionID)
    	REFERENCES transaction(transactionID),
CONSTRAINT comp_prim_transaction PRIMARY KEY(isbn, transactionID));

INSERT INTO transaction_line
VALUES (1, 4569871236543, 11.99, 7000001);
INSERT INTO transaction_line
VALUES (3, 9836821956243, 12.99, 7000002);
INSERT INTO transaction_line
VALUES (1, 8215409823467, 11.99, 7000002);
INSERT INTO transaction_line
VALUES (1, 9836821956243, 12.99, 7000003);
INSERT INTO transaction_line
VALUES (1, 7390458192345, 11.49, 7000003);
INSERT INTO transaction_line
VALUES (1, 7390458192345, 11.49, 7000004);
INSERT INTO transaction_line
VALUES (1, 9836821956243, 12.99, 7000005);
INSERT INTO transaction_line
VALUES (3, 7390458192345, 11.49, 7000005);
INSERT INTO transaction_line
VALUES (2, 7329871292541, 11.99, 7000005);

SUPPLIER
CREATE TABLE supplier
	(supplierID number
    	CONSTRAINT sup_pk PRIMARY KEY,
	Supplier_name varchar2 (50)
    	CONSTRAINT sup_null NOT NULL);

INSERT INTO supplier
VALUES(1000001,  'Ready Books');
INSERT INTO supplier
VALUES(1000002,  'Adventure Book Warehouse');
INSERT INTO supplier
VALUES(1000003,  'Help Yourself Book Company');
INSERT INTO supplier
VALUES(1000004,  'Drama Dave Book Warehouse');
INSERT INTO supplier
VALUES(1000005,  'Alpha Books');


CATALOGUE LINE
CREATE TABLE catalogue_line
	(supplierID number,
	ISBN number(13),
	Quantity number
    	CONSTRAINT quantity2_null NOT NULL,
	Price number
    	CONSTRAINT price_round CHECK ( Price=ROUND(Price, 2))
    	CONSTRAINT price2_null NOT NULL,
    	CONSTRAINT cid_fk FOREIGN KEY (supplierID)
    	REFERENCES supplier(supplierID),
    	CONSTRAINT isbn3_fk FOREIGN KEY (isbn)
    	REFERENCES book(ISBN),
CONSTRAINT primary_key_catline PRIMARY KEY(isbn, supplierID));

INSERT INTO catalogue_line
VALUES (1000001, 4569871236543, 10000, 8.55);
INSERT INTO catalogue_line
VALUES (1000001, 7329871292541, 15000, 7.30);
INSERT INTO catalogue_line
VALUES (1000001, 9836821956243, 20000, 4.95);
INSERT INTO catalogue_line
VALUES (1000002, 4569871236543, 8000, 8.32);
INSERT INTO catalogue_line
VALUES (1000002, 7329871292541, 17000, 7.54);
INSERT INTO catalogue_line
VALUES (1000002, 9836821956243, 7500, 4.32);
INSERT INTO catalogue_line
VALUES (1000002, 8215409823467, 300000, 7.65);
INSERT INTO catalogue_line
VALUES (1000003, 4569871236543, 12000, 7.99);
INSERT INTO catalogue_line
VALUES (1000003, 7329871292541, 13500, 5.23);
INSERT INTO catalogue_line
VALUES (1000003, 9836821956243, 21236, 6.23);
INSERT INTO catalogue_line
VALUES (1000003, 8215409823467, 5682, 8.22);
INSERT INTO catalogue_line
VALUES (1000003, 7390458192345, 10200, 5.55);
INSERT INTO catalogue_line
VALUES (1000004, 7329871292541, 5000, 4.99);
INSERT INTO catalogue_line
VALUES (1000004, 9836821956243, 6000, 5.99);
INSERT INTO catalogue_line
VALUES (1000004, 8215409823467, 7000, 6.99);
INSERT INTO catalogue_line
VALUES (1000004, 7390458192345, 8000, 7.99);
INSERT INTO catalogue_line
VALUES (1000005, 9836821956243, 15000, 5.51);
INSERT INTO catalogue_line
VALUES (1000005, 8215409823467, 20000, 7.21);
INSERT INTO catalogue_line
VALUES (1000005, 7390458192345, 12000, 7.51);

WAREHOUSE
CREATE TABLE warehouse
(warehouseID number
    CONSTRAINT wid2_PK PRIMARY KEY,
Street_address varchar2 (50)
    CONSTRAINT sa_null NOT NULL,
city varchar2 (50)
    CONSTRAINT city2_null NOT NULL,
State varchar2 (2)
    CONSTRAINT st_null NOT NULL,
Zip_code number (5)
    CONSTRAINT zc_null NOT NULL);

INSERT INTO warehouse
VALUES (3000001, '9140 Pawnee Ave.', 'Highland', 'IN', 46322);
INSERT INTO warehouse
VALUES (3000002, '9784 Wrangler Drive', 'Newnan', 'GA', 30263);
INSERT INTO warehouse
VALUES (3000003, '8918 N. Middle River Rd.', 'Annandale', 'VA', 22003);
INSERT INTO warehouse
VALUES (3000004, '9261 County St.', 'Highland', 'IN', 46322);
INSERT INTO warehouse
VALUES (3000005, '88 Jefferson St.', 'Manahawkin', 'NJ', 08050);
INSERT INTO warehouse
VALUES (3000006, '245 Buckley Rd', 'Santa Barbara', 'CA', 96234);


WAREHOUSE INVENTORY
CREATE TABLE warehouse_inventory
	(ISBN number(13),
	warehouseID number,
	CONSTRAINT ware_fk FOREIGN KEY(warehouseID)
	REFERENCES warehouse(warehouseID),
	Quantity number
    	CONSTRAINT quanti_null NOT NULL,
    	CONSTRAINT isbn_fork FOREIGN KEY(isbn)
    	REFERENCES book(ISBN),
CONSTRAINT primary_comp_warehouse PRIMARY KEY(isbn, warehouseID));

INSERT INTO warehouse_inventory
VALUES(8215409823467, 3000001, 600);
INSERT INTO warehouse_inventory
VALUES(7329871292541, 3000001, 500);
INSERT INTO warehouse_inventory
VALUES(4569871236543, 3000002, 236);
INSERT INTO warehouse_inventory
VALUES(7329871292541, 3000002, 85);
INSERT INTO warehouse_inventory
VALUES(4569871236543, 3000003, 200);
INSERT INTO warehouse_inventory
VALUES(7329871292541, 3000003, 500);
INSERT INTO warehouse_inventory
VALUES(9836821956243, 3000004, 592);
INSERT INTO warehouse_inventory
VALUES(7390458192345, 3000004, 327);
INSERT INTO warehouse_inventory
VALUES(4569871236543, 3000004, 562);
INSERT INTO warehouse_inventory
VALUES(9836821956243, 3000005, 783);
INSERT INTO warehouse_inventory
VALUES(8215409823467, 3000005, 806);
INSERT INTO warehouse_inventory
VALUES(7390458192345, 3000006, 400);
INSERT INTO warehouse_inventory
VALUES(4569871236543, 3000006, 250);
INSERT INTO warehouse_inventory
VALUES(9836821956243, 3000003, 763);
INSERT INTO warehouse_inventory
VALUES(8215409823467, 3000003, 459);
INSERT INTO warehouse_inventory
VALUES(4569871236543, 3000005, 350);
INSERT INTO warehouse_inventory
VALUES(7329871292541, 3000004, 333);
INSERT INTO warehouse_inventory
VALUES(9836821956243, 3000001, 650);


RESTOCK ORDER
CREATE TABLE restock_order
	(restock_orderID number
    	CONSTRAINT restID_pk PRIMARY KEY,
	Date_ordered date
    	CONSTRAINT dateo_null NOT NULL,
storeID number 
CONSTRAINT stor_id2_nn NOT NULL,
warehouseID number
CONSTRAINT ware_id2_nn NOT NULL,
CONSTRAINT stor_fk2 FOREIGN KEY (storeID)
	REFERENCES store(storeID),
CONSTRAINT wareID_fk2 FOREIGN KEY (warehouseID)
    	REFERENCES warehouse(warehouseID));

INSERT INTO restock_order
	VALUES (2000001, to_date('07-28-2019', 'mm-dd-yyyy'), 4000003, 3000001);
INSERT INTO restock_order
	VALUES (2000002, to_date('08-15-2019', 'mm-dd-yyyy'), 4000001, 3000006);
INSERT INTO restock_order
	VALUES (2000003, to_date('09-12-2019', 'mm-dd-yyyy'), 4000002, 3000002);
INSERT INTO restock_order
	VALUES (2000004, to_date('05-23-2019', 'mm-dd-yyyy'), 4000005, 3000003);
INSERT INTO restock_order
	VALUES (2000005, to_date('05-27-2019', 'mm-dd-yyyy'), 4000003, 3000004);
INSERT INTO restock_order
	VALUES (2000006, to_date('06-23-2019', 'mm-dd-yyyy'), 4000004, 3000005);


RESTOCK ORDER LINE
CREATE TABLE restock_order_line
	(restock_orderID number,
	CONSTRAINT ro_fk FOREIGN KEY (restock_orderID)
    	REFERENCES restock_order (restock_orderID),
	ISBN number(13),
	CONSTRAINT isbn1_fk FOREIGN KEY (isbn)
    	REFERENCES book(ISBN),
	Quantity number
    	CONSTRAINT quantity_null NOT NULL,
CONSTRAINT restock_comp_prim PRIMARY KEY(restock_orderID, isbn));

INSERT INTO restock_order_line
	VALUES(2000001, 7329871292541, 40);
INSERT INTO restock_order_line
	VALUES(2000001, 9836821956243, 73);
INSERT INTO restock_order_line
	VALUES(2000002, 4569871236543, 40);
INSERT INTO restock_order_line
	VALUES(2000003, 4569871236543, 25);
INSERT INTO restock_order_line
	VALUES(2000003, 7329871292541, 46);
INSERT INTO restock_order_line
	VALUES(2000004, 7329871292541, 20);
INSERT INTO restock_order_line
	VALUES(2000004, 9836821956243, 70);
INSERT INTO restock_order_line
	VALUES(2000004, 8215409823467, 120);
INSERT INTO restock_order_line
	VALUES(2000005, 9836821956243, 35);
INSERT INTO restock_order_line
	VALUES(2000005, 7390458192345, 70);
INSERT INTO restock_order_line
	VALUES(2000006, 8215409823467, 100);
INSERT INTO restock_order_line
	VALUES(2000006, 7329871292541, 53);


RESTOCK SHIPMENT
CREATE TABLE restock_shipment
	(restock_shipmentID number
    	CONSTRAINT resID_pk PRIMARY KEY,
	storeID number
	CONSTRAINT stid_null NOT NULL,
	CONSTRAINT stloc_fk FOREIGN KEY(storeID)
    	REFERENCES store(storeID),
	warehouseID number
	CONSTRAINT whid_null NOT NULL,
CONSTRAINT wid_fk FOREIGN KEY(warehouseID)
    	REFERENCES warehouse(warehouseID),
	Date_received date,
	Date_sent date,
	restock_orderID number,
	CONSTRAINT restock_fk FOREIGN KEY(restock_orderID)
    	REFERENCES restock_order(restock_orderID));

INSERT INTO restock_shipment
	VALUES (9000001, 4000003, 3000001, to_date('08-01-2019', 'mm-dd-yyyy'), to_date('07-30-2019', 'mm-dd-yyyy'), 2000001);
INSERT INTO restock_shipment
	VALUES (9000002, 4000001, 3000006, to_date('08-19-2019', 'mm-dd-yyyy'), to_date('08-17-2019', 'mm-dd-yyyy'), 2000002);
INSERT INTO restock_shipment
	VALUES (9000003, 4000002, 3000002, to_date('09-18-2019', 'mm-dd-yyyy'), to_date('09-17-2019', 'mm-dd-yyyy'), 2000003);
INSERT INTO restock_shipment
	VALUES (9000004, 4000005, 3000003, to_date('05-25-2019', 'mm-dd-yyyy'), to_date('05-24-2019', 'mm-dd-yyyy'), 2000004);
INSERT INTO restock_shipment
	VALUES (9000005, 4000003, 3000004, to_date('05-30-2019', 'mm-dd-yyyy'), to_date('05-28-2019', 'mm-dd-yyyy'), 2000005);
INSERT INTO restock_shipment
	VALUES (9000006, 4000004, 3000005, to_date('06-30-2019', 'mm-dd-yyyy'), to_date('06-26-2019', 'mm-dd-yyyy'), 2000006);


ORDERS

CREATE TABLE Orders
    (orderID number
        CONSTRAINT orderID_pk PRIMARY KEY,
    order_date date
        CONSTRAINT orderD_null NOT NULL,
    warehouseID number,
    supplierID number,
    Product_cost number
        CONSTRAINT prod_null NOT NULL,
    Shipping_cost number,
    Status varchar2 (50) NOT NULL
    CONSTRAINT check_status_value CHECK (Status IN ('Accepted', 'Rejected',
'Submitted')),
    CONSTRAINT wareID_fk FOREIGN KEY (warehouseID)
        REFERENCES warehouse(warehouseID),
    CONSTRAINT supID_fk FOREIGN KEY (supplierID)
        REFERENCES supplier(supplierID));


INSERT INTO orders
	VALUES (6000001, to_date('01-28-2019', 'mm-dd-yyyy'), 3000001, 1000001, 4275, 100, 'Accepted');
INSERT INTO orders
VALUES (6000002, to_date('02-25-2019', 'mm-dd-yyyy'), 3000002, 1000002, 2804, 100, 'Accepted');
INSERT INTO orders
VALUES (6000003, to_date('03-23-2019', 'mm-dd-yyyy'), 3000003, 1000003, 12358.50, 350, 'Accepted');
INSERT INTO orders
VALUES (6000004, to_date('04-28-2019', 'mm-dd-yyyy'), 3000004, 1000004, 16378, 440, 'Accepted');
INSERT INTO orders
VALUES (6000005, to_date('05-01-2019', 'mm-dd-yyyy'), 3000005, 1000005, 14420, 400, 'Accepted');
INSERT INTO orders
VALUES (6000006, to_date('05-15-2019', 'mm-dd-yyyy'), 3000005, 1000005, 57680, 1600, 'Rejected');




ACCEPTED ORDER SHIPMENT
CREATE TABLE accepted_order_shipment
	(accepted_order_shipmentID number
    	CONSTRAINT aos_pk PRIMARY KEY,
	Date_sent date,
	Date_received date,
	orderID number
    	CONSTRAINT orderid_null NOT NULL,
	CONSTRAINT orderid_fk FOREIGN KEY(orderID)
    	REFERENCES orders(orderID));

INSERT INTO accepted_order_shipment
VALUES (11000001, to_date('01-31-2019', 'mm-dd-yyyy'), to_date('02-02-2019', 'mm-dd-yyyy'), 6000001);
INSERT INTO accepted_order_shipment
VALUES (11000002, to_date('02-26-2019', 'mm-dd-yyyy'), to_date('03-01-2019', 'mm-dd-yyyy'), 6000002);
INSERT INTO accepted_order_shipment
VALUES (11000003, to_date('03-25-2019', 'mm-dd-yyyy'), to_date('03-27-2019', 'mm-dd-yyyy'), 6000003);
INSERT INTO accepted_order_shipment
VALUES (11000004, to_date('04-30-2019', 'mm-dd-yyyy'), to_date('05-03-2019', 'mm-dd-yyyy'), 6000004);
INSERT INTO accepted_order_shipment
VALUES (11000005, to_date('05-02-2019', 'mm-dd-yyyy'), to_date('05-05-2019', 'mm-dd-yyyy'), 6000005);


ORDER LINE
CREATE TABLE order_line
	(orderID number,
	ISBN number(13),
	Quantity number
    	CONSTRAINT quan_null NOT NULL,
	CONSTRAINT oid_fk FOREIGN KEY(orderID)
    	REFERENCES orders(orderID),
	CONSTRAINT isbn9_fk FOREIGN KEY (isbn)
    	REFERENCES book(ISBN),
CONSTRAINT pk_ol_comp PRIMARY KEY(orderID, ISBN));

INSERT INTO order_line
VALUES (6000001, 4569871236543, 500);
INSERT INTO order_line
VALUES (6000002, 7329871292541, 200);
INSERT INTO order_line
VALUES (6000002, 9836821956243, 300);
INSERT INTO order_line
VALUES (6000003, 9836821956243, 750);
INSERT INTO order_line
VALUES (6000003, 8215409823467, 800);
INSERT INTO order_line
VALUES (6000003, 7390458192345, 200);
INSERT INTO order_line
VALUES (6000004, 8215409823467, 1200);
INSERT INTO order_line
VALUES (6000004, 7390458192345, 1000);
INSERT INTO order_line
VALUES (6000005, 8215409823467, 2000);
INSERT INTO order_line
VALUES (6000006, 8215409823467, 22000);


QUERIES:
We wanted to look at how frequently we order from each supplier, and see if one of our suppliers tend to be most popular in comparison to others.  (We want to include all orders, even if they are in the Rejected or Submitted status.)

select supplier_name, count(*) AS "Count"
	from orders full join supplier on orders.supplierid=supplier.supplierid
	group by supplier.supplier_name
	order by count(*) desc;


The business analyst wants to ensure we have the minimum number of books required for store 4000001.  We need to make sure we have at least 40 of each of the booksin the store inventory.  (We do not care about books that the store has never carried and does not currently carry. I.e. non-existing ISBNs for that store). Provide a list of ISBNs and book names that are below this quantity for that store and how many copies of the book(s) need to be ordered to meet this quantity.

select a.ISBN, title, 40 - a.quantity as "Copies Needed"
from store_inventory a
join book b
on a.isbn = b.isbn
where storeID = 4000001 and quantity < 40;




A customer came into our Morgan Hill store and was looking for ‘The Three Pigs’, but it wasn’t in stock.  The customer doesn’t know the author or the ISBN and is open to purchasing any edition.  Provide a list of stores (with the full address) where book(s) of this title is in stock and the quantity of books in stock at each of these stores.

SELECT store_inventory.storeID, store.street_address|| ' '||store.city||' '||store.state|| ' '
||store.zip_code AS "Address", store_inventory.quantity 
FROM store_inventory JOIN store ON store_inventory.storeID=store.storeID
join book on store_inventory.isbn = book.isbn
WHERE title = 'The Three Pigs';



We are considering purchasing the entire inventory of one of our suppliers.  As a starting point for the negotiations we will begin making, we want to know the total product cost of each supplier’s inventory at current catalogue prices.

	SELECT supplier_name, sum(quantity * price) as "Total Product Cost"
FROM catalogue_line a
join supplier b on a.supplierid = b.supplierid
group by supplier_name
order by supplier_name;



We are considering liquidating our entire inventory from all of our stores and warehouses.  Provide a list of ISBN, Title, and Total quantity from all of our stores and warehouses combined.  Order this list ascending by Title.

	select a.isbn, title, sum(quantity) as "Total Quantity" from
(select isbn, quantity
from store_inventory
Union
select isbn, quantity
from warehouse_inventory) a
join book b on a.isbn = b.isbn
group by a.isbn, title
order by title;

