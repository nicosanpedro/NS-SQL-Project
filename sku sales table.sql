--DROP TABLE skusales;

--RAW DATA
SELECT *
FROM raw_sku_sales;

--------------------------------------------------------------------------------
--CREATING TABLE
--------------------------------------------------------------------------------
CREATE TABLE sku_sales(
	productsku VARCHAR,
	totalordered VARCHAR
);

--------------------------------------------------------------------------------
--INSERTING DATA
--------------------------------------------------------------------------------
INSERT INTO sku_sales
SELECT *
FROM raw_sku_sales
OFFSET 1; --OFFSET 1 ROW

--------------------------------------------------------------------------------
--ALTERING DATA TYPE
--------------------------------------------------------------------------------
ALTER TABLE sku_sales
ALTER COLUMN productsku TYPE VARCHAR,
ALTER COLUMN totalordered TYPE NUMERIC USING totalordered :: NUMERIC;


--------------------------------------------------------------------------------
--CREATING PRIMARY KEYS
--------------------------------------------------------------------------------
-- SKU SALES PK
ALTER TABLE sku_sales
ADD COLUMN salesid VARCHAR,
ADD COLUMN salesnum SERIAL,
ADD COLUMN salestext VARCHAR DEFAULT 'SA';

UPDATE sku_sales
SET salesid = salestext || salesnum :: VARCHAR;

ALTER TABLE sku_sales
DROP COLUMN salesnum,
DROP COLUMN salestext,
ADD PRIMARY KEY(salesid);

