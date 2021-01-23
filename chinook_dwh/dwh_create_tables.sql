CREATE TABLE date_dim
(
    dateID INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
    InvoiceDate DATE NOT NULL,
    year INT NOT NULL,
    month SMALLINT NOT NULL,
    day SMALLINT NOT NULL,
    dayName NVARCHAR2(15) NOT NULL,
    dayOfWeek SMALLINT NOT NULL,
    week SMALLINT NOT NULL,
    quarter SMALLINT NOT NULL,
    CONSTRAINT PK_date_dim PRIMARY KEY  (dateID)
);

CREATE TABLE customer_dim
(
    CustomerId NUMBER NOT NULL,
    FirstName VARCHAR2(40) NOT NULL,
    LastName VARCHAR2(20) NOT NULL,
    Company VARCHAR2(80),
    Address VARCHAR2(70),
    City VARCHAR2(40),
    State VARCHAR2(40),
    Country VARCHAR2(40),
    PostalCode VARCHAR2(10),
    Phone VARCHAR2(24),
    Fax VARCHAR2(24),
    Email VARCHAR2(60) NOT NULL,
    SupportRepId NUMBER,
    CONSTRAINT PK_Customer_dim PRIMARY KEY  (CustomerId)
);

CREATE TABLE invoice_dim
(
    InvoiceId NUMBER NOT NULL,
    BillingAddress VARCHAR2(70),
    BillingCity VARCHAR2(40),
    BillingState VARCHAR2(40),
    BillingCountry VARCHAR2(40),
    BillingPostalCode VARCHAR2(10),
    Total NUMBER(10,2) NOT NULL,
    CONSTRAINT PK_Invoice_dim PRIMARY KEY (InvoiceId)
);

CREATE TABLE invoice_fact
(
    InvoiceLineId NUMBER NOT NULL, 
    InvoiceId NUMBER NOT NULL,
    TrackId NUMBER NOT NULL, 
    dateID NUMBER NOT NULL, 
    CustomerId NUMBER NOT NULL,
    UnitPrice NUMBER(10,2) NOT NULL, 
    Quantity NUMBER NOT NULL
);

CREATE TABLE track_dim
(
    TRACKID NUMBER, 
    NAME VARCHAR2(200),
    COMPOSER VARCHAR2(200), 
    MILLISECONDS NUMBER, 
    BYTES NUMBER, 
    UNITPRICE NUMBER(10,2),
    MEDIATYPE VARCHAR2(120),
    GENRE VARCHAR2(120), 
    ALBUM VARCHAR2(160), 
    ARTIST VARCHAR2(120)
);

