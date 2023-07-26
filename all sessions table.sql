--DROP TABLE all_sessions;
--RAW DATA
SELECT *
FROM raw_all_sessions;

--------------------------------------------------------------------------------
--CREATE SESSIONS TABLE
--------------------------------------------------------------------------------
CREATE TABLE all_sessions(
	visitorID VARCHAR,
	channelGrouping VARCHAR,
	sessiontime VARCHAR,
	country VARCHAR,
	city VARCHAR,
	totaltransactionrevenue VARCHAR,
	transactions VARCHAR,
	timeonsite VARCHAR,
	pageviews VARCHAR,
	sessionqualitydim VARCHAR,
	sessiondate VARCHAR,
	visitid VARCHAR,
	visittype VARCHAR,
	productrefundamount VARCHAR,
	productquantity VARCHAR,
	productprice VARCHAR,
	productrevenue VARCHAR,
	productsku VARCHAR,
	productname VARCHAR,
	productcategory VARCHAR,
	productvariant VARCHAR,
	currencycode VARCHAR,
	itemquantity VARCHAR,
	itemrevenue VARCHAR,
	transrevenue VARCHAR,
	transid VARCHAR,
	pagetitle VARCHAR,
	searchkeyword VARCHAR,
	pagepathlevel VARCHAR,
	ecommerceactiontype VARCHAR,
	ecommerceactionstep VARCHAR,
	ecommerceactionoption VARCHAR
);

--CHECKDUPLICATE KEY
SELECT "visitorID", COUNT(*)
FROM public.raw_all_sessions
GROUP BY 1 
ORDER BY 2 DESC;

-- INSERTING RAW DATA TO TABLE
INSERT INTO all_sessions
SELECT * 
FROM raw_all_sessions
OFFSET 1; --REMOVE FIRST ROW

--------------------------------------------------------------------------------
--ALTERING TABLE COLUMN DATA TYPE
--------------------------------------------------------------------------------
ALTER TABLE all_sessions
ALTER COLUMN visitorID TYPE VARCHAR,
ALTER COLUMN channelGrouping TYPE VARCHAR,
ALTER COLUMN sessiontime TYPE NUMERIC USING sessiontime :: NUMERIC,
ALTER COLUMN country TYPE VARCHAR,
ALTER COLUMN city TYPE VARCHAR,
ALTER COLUMN totaltransactionrevenue TYPE NUMERIC USING totaltransactionrevenue :: NUMERIC,
ALTER COLUMN transactions TYPE NUMERIC USING transactions :: NUMERIC,
ALTER COLUMN timeonsite TYPE NUMERIC USING timeonsite :: NUMERIC,
ALTER COLUMN pageviews TYPE NUMERIC USING pageviews :: NUMERIC,
ALTER COLUMN sessionqualitydim TYPE NUMERIC USING sessionqualitydim :: NUMERIC,
ALTER COLUMN sessiondate TYPE DATE USING sessiondate :: DATE,
ALTER COLUMN visitid TYPE VARCHAR,
ALTER COLUMN visittype TYPE VARCHAR,
ALTER COLUMN productrefundamount TYPE NUMERIC USING productrefundamount :: NUMERIC,
ALTER COLUMN productquantity TYPE NUMERIC USING productquantity :: NUMERIC,
ALTER COLUMN productprice TYPE NUMERIC USING productprice :: NUMERIC,
ALTER COLUMN productrevenue TYPE NUMERIC USING productrevenue :: NUMERIC,
ALTER COLUMN productsku TYPE VARCHAR,
ALTER COLUMN productname TYPE VARCHAR,
ALTER COLUMN productcategory TYPE VARCHAR,
ALTER COLUMN productvariant TYPE VARCHAR,
ALTER COLUMN currencycode TYPE VARCHAR,
ALTER COLUMN itemquantity TYPE NUMERIC USING itemquantity :: NUMERIC,
ALTER COLUMN itemrevenue TYPE NUMERIC USING itemrevenue :: NUMERIC,
ALTER COLUMN transrevenue TYPE NUMERIC USING transrevenue :: NUMERIC,
ALTER COLUMN transid TYPE VARCHAR,
ALTER COLUMN pagetitle TYPE VARCHAR,
ALTER COLUMN searchkeyword TYPE VARCHAR,
ALTER COLUMN pagepathlevel TYPE VARCHAR,
ALTER COLUMN ecommerceactiontype TYPE NUMERIC USING ecommerceactiontype :: NUMERIC,
ALTER COLUMN ecommerceactionstep TYPE NUMERIC USING ecommerceactionstep :: NUMERIC,
ALTER COLUMN ecommerceactionoption TYPE VARCHAR;

--ALL SESSIONS TABLE
SELECT *
FROM all_sessions;

--------------------------------------------------------------------------------
--CORRECTING PRICES
--------------------------------------------------------------------------------
UPDATE all_sessions
SET productprice = productprice / 1000000;
UPDATE all_sessions
SET productrevenue = productrevenue / 1000000;
UPDATE all_sessions
SET totaltransactionrevenue = totaltransactionrevenue / 1000000;
UPDATE all_sessions
SET transrevenue = transrevenue / 1000000;


--------------------------------------------------------------------------------
--CREATING PRIMARY KEYS
--------------------------------------------------------------------------------

--1. ALL SESSIONS PK
ALTER TABLE all_sessions
ADD COLUMN sessionid VARCHAR,
ADD COLUMN sessionnum SERIAL,
ADD COLUMN sessiontext VARCHAR DEFAULT 'S';

UPDATE all_sessions
SET sessionid = sessiontext || sessionnum :: VARCHAR;

ALTER TABLE all_sessions
DROP COLUMN sessionnum,
DROP COLUMN sessiontext,
ADD PRIMARY KEY(sessionid);


--------------------------------------------------------------------------------
---CORRECTING PRODUCT CATEGORY
--------------------------------------------------------------------------------

-- SELECT * 
-- FROM all_sessions
-- WHERE productcategory LIKE '%Lifestyle/%' 
-- 	OR productcategory LIKE 'Bags' 
-- 	OR productcategory LIKE 'Bottles' 
-- 	OR productcategory LIKE 'Drinkware' 
-- 	OR productcategory LIKE 'Electronics' 
-- 	OR productcategory LIKE 'Headgear'
	

UPDATE all_sessions
SET productcategory = 'Apparel'
WHERE productcategory ILIKE '%apparel%' OR
	productcategory ILIKE '%T-Shirts%';

UPDATE all_sessions
SET productcategory = 'Bags'
WHERE productcategory ILIKE '%Bags%';

UPDATE all_sessions
SET productcategory = 'Bottles'
WHERE productcategory ILIKE '%Bottles%';

UPDATE all_sessions
SET productcategory = 'Drinkware'
WHERE productcategory ILIKE '%Drinkware%';

UPDATE all_sessions
SET productcategory = 'Electronics'
WHERE productcategory ILIKE '%Electronics%';

UPDATE all_sessions
SET productcategory = 'Headgear'
WHERE productcategory ILIKE '%Headgear%';

UPDATE all_sessions
SET productcategory = 'Office'
WHERE productcategory ILIKE '%Office%';

UPDATE all_sessions
SET productcategory = 'Sale'
WHERE productcategory ILIKE '%Sale%';

UPDATE all_sessions
SET productcategory = 'Accessories'
WHERE productcategory ILIKE '%Accessories'; --gets all accessories category

UPDATE all_sessions
SET productcategory = 'Pet'
WHERE productcategory ILIKE '%Pet%';

UPDATE all_sessions
SET productcategory = 'Nest'
WHERE productcategory ILIKE '%Nest%';

UPDATE all_sessions
SET productcategory = 'Nest'
WHERE productcategory ILIKE '%Nest%';

UPDATE all_sessions
SET productcategory = 'Lifestyle'
WHERE productcategory ILIKE '%Lifestyle%';

UPDATE all_sessions
SET productcategory = REPLACE(productcategory,'Home/Shop by Brand/', '')
WHERE productcategory ILIKE '%Home/Shop by Brand/%';

UPDATE all_sessions
SET productcategory = REPLACE(productcategory,'Home/Accessories/', '')
WHERE productcategory ILIKE '%Home/Accessories/%';

UPDATE all_sessions
SET productcategory = REPLACE(productcategory,'Home/Brands/', '')
WHERE productcategory ILIKE '%Home/Brands/%';


UPDATE all_sessions
SET productcategory = REPLACE(productcategory,'Home/', '')
WHERE productcategory ILIKE '%Home/%';

UPDATE all_sessions
SET productcategory = CASE 
                      WHEN RIGHT(productcategory, 1) = '/' THEN
                          SUBSTRING(productcategory, 1, LENGTH(productcategory) - 1)
                      ELSE 
                          productcategory 
                  END;

UPDATE all_sessions
SET city = ''
WHERE city ILIKE '%not available in demo dataset%';
