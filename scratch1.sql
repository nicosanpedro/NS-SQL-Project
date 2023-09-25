--ALL TABLES

'''SELECT *
FROM sales_report;

SELECT *
FROM all_sessions
where visitid = '1498800073'

SELECT *
FROM analytics
where unitsold is not null

SELECT * 
FROM products;

SELECT * 
FROM sku_sales'''

--------------------------------------------------------------------------------
---CORRECTING PRICE
--------------------------------------------------------------------------------
--1. ANALYTICS
'''SELECT * 
FROM analytics
WHERE unitsold IS NOT NULL;

UPDATE analytics
SET unitprice = unitprice / 1000000;'''


--2. ALL SESSIONS
'''UPDATE all_sessions
SET productprice = productprice / 1000000;
UPDATE all_sessions
SET productrevenue = productrevenue / 1000000;
UPDATE all_sessions
SET totaltransactionrevenue = totaltransactionrevenue / 1000000;
UPDATE all_sessions
SET transrevenue = transrevenue / 1000000;'''

-- UPDATE all_sessions
-- SET itemquantity = itemquantity / 1000000;
-- UPDATE all_sessions
-- SET itemrevenue = itemrevenue / 1000000;

--3. Products
'''SELECT * 
FROM products'''

--4. Sales Report

'''SELECT * 
FROM sales_report'''

--5. sku_sales
'''SELECT * 
FROM sku_sales'''

--------------------------------------------------------------------------------
---CORRECTING PRODUCT CATEGORY
--------------------------------------------------------------------------------

'''SELECT * 
FROM all_sessions
WHERE productcategory LIKE '%Lifestyle/%' 
	OR productcategory LIKE 'Bags' 
	OR productcategory LIKE 'Bottles' 
	OR productcategory LIKE 'Drinkware' 
	OR productcategory LIKE 'Electronics' 
	OR productcategory LIKE 'Headgear'
	

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

--remove the last '/' value
UPDATE all_sessions
SET productcategory = SUBSTRING(productcategory, 1, LENGTH(productcategory) - 1)
WHERE LENGTH(productcategory) > 0;

UPDATE all_sessions
SET productcategory = REPLACE(productcategory,'Home/', '')
WHERE productcategory ILIKE '%Home/%';'''




 



