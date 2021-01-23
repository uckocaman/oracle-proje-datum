CREATE OR REPLACE VIEW number_of_customers_by_country AS
SELECT Country, COUNT(*) AS "Number Of Customer" FROM CUSTOMER_DIM
GROUP BY Country
ORDER BY COUNT(*) DESC;

 CREATE OR REPLACE VIEW sales_revenue_by_country AS
SELECT bıllıngcountry AS country, COUNT(*) AS total_sales, SUM(UNITPRICE) AS revenue 
FROM invoice_fact fact 
LEFT JOIN invoice_dim invoice ON fact.INVOICEID = invoice.INVOICEID 
GROUP BY bıllıngcountry, UNITPRICE 
ORDER BY total_sales DESC;

CREATE OR REPLACE VIEW GenreCountry AS
SELECT td.genre as GENRE, cd.country AS COUNTRY, COUNT(*) AS "Number of Purchases" FROM ınvoıce_fact IF
INNER JOIN customer_dım CD ON ıf.customerıd = cd.customerıd
INNER JOIN track_dım TD ON ıf.trackıd = td.trackıd
GROUP BY cd.country, td.genre
ORDER BY COUNT(*) DESC;

CREATE OR REPLACE VIEW total_time_of_tracks AS
SELECT ıf_.customerıd, cd.FIRSTNAME, SUM(TD.MILLISECONDS) AS "Total Milliseconds",
ROUND(mod(SUM(TD.MILLISECONDS) / (1000 * 60*60),24),2) AS hours
FROM track_dım TD
INNER JOIN ınvoıce_fact IF_ ON td.trackıd = ıf_.trackıd
INNER JOIN customer_dım CD ON ıf_.customerıd = cd.customerıd
GROUP BY ıf_.customerıd, cd.FIRSTNAME
ORDER BY SUM(TD.MILLISECONDS) DESC;

CREATE OR REPLACE VIEW mediatype_count AS
SELECT medıatype, COUNT(medıatype) AS COUNT FROM track_dım
GROUP BY medıatype 
ORDER BY COUNT(medıatype) DESC;

CREATE OR REPLACE VIEW number_of_sales_this_week AS
SELECT COUNT(ıfa.ınvoıceıd) "Number of Sales" FROM ınvoıce_fact IFA
INNER JOIN date_dım DD ON ıfa.dateıd = dd.dateıd
WHERE dd.week = to_char(CURRENT_DATE, 'WW') AND dd.year = to_char(CURRENT_DATE, 'YYYY');
SELECT * FROM number_of_sales_this_week;

CREATE OR REPLACE VIEW best_customer AS
SELECT c.FIRSTNAME As CustomerName, round(sum(i.TOTAL),2) As AmountSpent FROM invoice i
INNER JOIN customer c on i.CUSTOMERID = c.CUSTOMERID
INNER JOIN invoice_dim id ON i.INVOICEID = id.INVOICEID
GROUP BY c.FIRSTNAME
ORDER BY AmountSpent DESC
FETCH NEXT 1 ROWS ONLY;

CREATE OR REPLACE VIEW top10Track AS
SELECT track.NAME, track.ARTIST, COUNT(*) AS total FROM invoice_fact fact 
LEFT JOIN track_dim track ON fact.TRACKID = track.TRACKID 
GROUP BY track.name, track.artist 
ORDER BY  COUNT(*) DESC
FETCH NEXT 10 ROWS ONLY;

CREATE OR REPLACE VIEW US_UK_CND_Revenue AS
SELECT dd.year, SUM(CASE WHEN ID.bıllıngcountry = 'USA' THEN ID.total END) AS "USA",
                SUM(CASE WHEN ID.bıllıngcountry = 'United Kingdom' THEN ID.total END) AS "United Kingdom",
                SUM(CASE WHEN ID.bıllıngcountry = 'Canada' THEN ID.total END) AS "Canada"
FROM INVOICE_DIM ID
INNER JOIN INVOICE_FACT IFA ON ID.INVOICEID = IFA.INVOICEID
INNER JOIN DATE_DIM DD ON IFA.DATEID = DD.DATEID
GROUP BY dd.year
ORDER BY DD.YEAR;

CREATE OR REPLACE VIEW genre_based_revenues_from_countries AS
SELECT billingcountry AS country, track.genre, SUM(fact.unitprice) AS revenue 
FROM invoice_fact fact 
LEFT JOIN ınvoıce_dım invoice ON fact.invoiceid = invoice.invoiceid 
LEFT JOIN track_dım track ON fact.trackid = track.trackid 
GROUP BY billingcountry, track.genre, fact.unitprice 
ORDER BY country, revenue DESC;

CREATE OR REPLACE VIEW number_of_music_genres AS
SELECT track.genre, COUNT(*) AS COUNT FROM invoice_fact fact 
LEFT JOIN track_dim track ON fact.trackid = track.trackid 
GROUP BY track.genre 
ORDER BY COUNT(*) DESC;

CREATE OR REPLACE VIEW artists_total_songs AS
SELECT artist, COUNT(*) AS "TOTAL SONGS" FROM track_dim 
GROUP BY artist 
ORDER BY COUNT(*) DESC;

CREATE OR REPLACE VIEW unsold_artists AS
SELECT t.artist FROM track_dim t 
WHERE	NOT EXISTS (SELECT track.artist FROM invoice_fact fact 
					LEFT JOIN track_dim track ON fact.trackid = track.trackid 
					WHERE track.artist=t.artist 
					GROUP BY track.artist) 
GROUP BY t.artist;

CREATE OR REPLACE VIEW longest_track AS
SELECT name, artist, album, ROUND(MOD(milliseconds / (1000 * 60), 60),2) AS MINUTES 
FROM track_dim 
WHERE	milliseconds = (SELECT MAX(milliseconds) FROM track_dim);

CREATE OR REPLACE VIEW top10days AS
SELECT d.INVOICEDATE, COUNT(*) AS TOTAL FROM invoice_fact fact 
LEFT JOIN date_dim d ON fact.dateid = d.dateid 
GROUP BY d.INVOICEDATE 
ORDER BY TOTAL DESC
FETCH NEXT 10 ROWS ONLY;

CREATE OR REPLACE VIEW number_of_sales_by_day
AS
select dd.dayname, count(*) as sales_count
from invoice_fact f inner join date_dim dd on f.dateid = dd.dateid
group by dd.dayname
order by 2 desc