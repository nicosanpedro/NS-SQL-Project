--DROP TABLE products;
-- RAW DATA
'''SELECT * 
FROM raw_products;'''

--------------------------------------------------------------------------------
--CREATE NEW PRODUCTS TABLE
--------------------------------------------------------------------------------
'''CREATE TABLE products(
	sku VARCHAR PRIMARY KEY,
	productName VARCHAR,
	orderedQuantity VARCHAR,
	stockLevel VARCHAR,
	restockingLeadTime VARCHAR,
	sentimentScore VARCHAR,
	sentimentMagnitude VARCHAR
);'''

--------------------------------------------------------------------------------
-- INSERTING RAW DATA TO TABLE
--------------------------------------------------------------------------------
'''INSERT INTO products
SELECT * 
FROM raw_products
OFFSET 1; --REMOVE FIRST ROW'''

--------------------------------------------------------------------------------
--ALTERING TABLE COLUMN DATA TYPE
--------------------------------------------------------------------------------
'''ALTER TABLE products
ALTER COLUMN sku TYPE VARCHAR,
ALTER COLUMN productName TYPE VARCHAR,
ALTER COLUMN orderedQuantity TYPE NUMERIC USING orderedquantity::NUMERIC,
ALTER COLUMN stockLevel TYPE NUMERIC USING stocklevel::NUMERIC,
ALTER COLUMN restockingLeadTime TYPE NUMERIC USING restockingLeadTime::numeric,
ALTER COLUMN sentimentScore TYPE NUMERIC USING sentimentScore::NUMERIC,
ALTER COLUMN sentimentMagnitude TYPE NUMERIC USING sentimentMagnitude::NUMERIC;'''

