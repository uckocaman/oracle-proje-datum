INSERT INTO date_dim (InvoiceDate, year, month, day, dayName, dayOfWeek ,week, quarter)
SELECT INVOICEDATE, to_char(INVOICEDATE, 'YYYY'), to_char(INVOICEDATE, 'MM'), to_char(INVOICEDATE, 'DD'),to_char(INVOICEDATE, 'DAY'),
to_char(INVOICEDATE, 'D'), to_char(INVOICEDATE, 'WW'), to_char(INVOICEDATE, 'Q')  from INVOICE

INSERT INTO customer_dim (CustomerId, FirstName, LastName, Company, Address, City ,State, Country,PostalCode,Phone, Fax,Email,SupportRepId)SELECT  CustomerId, FirstName, LastName, Company, Address, City ,State, Country,PostalCode,Phone, Fax,Email,SupportRepId from Customer

INSERT INTO invoice_dim (InvoiceId, BillingAddress, BillingCity,BillingState, BillingCountry, BillingPostalCode, Total)
SELECT InvoiceId, BillingAddress, BillingCity, BillingState, BillingCountry, BillingPostalCode, Total   from INVOICE

INSERT INTO invoice_fact (InvoiceLineId, InvoiceId, TrackId, dateID, CustomerId, UnitPrice, Quantity)
SELECT IL.INVOICELINEID, I.INVOICEID, IL.TrackId, DD.dateID, I.CustomerId, IL.UnitPrice, IL.Quantity from INVOICELINE IL
INNER JOIN INVOICE I ON IL.INVOICEID = I.INVOICEID
INNER JOIN date_dim DD ON I.INVOICEDATE = DD.InvoiceDate

INSERT INTO track_dim (TRACKID, NAME, COMPOSER, MILLISECONDS, BYTES, UNITPRICE, MEDIATYPE, GENRE, ALBUM, ARTIST)
SELECT T.TRACKID, T.NAME, T.COMPOSER, T.MILLISECONDS, T.BYTES, T.UNITPRICE, MT.NAME, G.NAME, A.TITLE, AR.NAME from TRACK T
INNER JOIN MEDIATYPE MT ON T.MEDIATYPEID = MT.MEDIATYPEID
INNER JOIN GENRE G ON T.GENREID = G.GENREID
INNER JOIN ALBUM A ON T.ALBUMID = A.ALBUMID
INNER JOIN ARTIST AR ON AR.ARTISTID = A.ARTISTID