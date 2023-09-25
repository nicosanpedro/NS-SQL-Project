What issues will you address by cleaning the data?
1. Incorrect data type
2. Incorrect numeric values on prices
3. Messy product category




Queries:
Below, provide the SQL queries you used to clean your data.
------------------------------------------------------------------------------------------------------------------------------------
1. Incorrect Data Type: Create a new table for cleaned data and correct the data type after
------------------------------------------------------------------------------------------------------------------------------------
--PRODUCTS TABLE

    --CREATE NEW PRODUCTS TABLE
    '''CREATE TABLE products(
    	sku VARCHAR PRIMARY KEY,
    	productName VARCHAR,
    	orderedQuantity VARCHAR,
    	stockLevel VARCHAR,
    	restockingLeadTime VARCHAR,
    	sentimentScore VARCHAR,
    	sentimentMagnitude VARCHAR
    );'''
    
    -- INSERTING RAW DATA TO TABLE
    --------------------------------------------------------------------------------
    INSERT INTO products
    SELECT * 
    FROM raw_products
    OFFSET 1; --REMOVE FIRST ROW

    --ALTERING TABLE COLUMN DATA TYPE
    --------------------------------------------------------------------------------
    ALTER TABLE products
    ALTER COLUMN sku TYPE VARCHAR,
    ALTER COLUMN productName TYPE VARCHAR,
    ALTER COLUMN orderedQuantity TYPE NUMERIC USING orderedquantity::NUMERIC,
    ALTER COLUMN stockLevel TYPE NUMERIC USING stocklevel::NUMERIC,
    ALTER COLUMN restockingLeadTime TYPE NUMERIC USING restockingLeadTime::numeric,
    ALTER COLUMN sentimentScore TYPE NUMERIC USING sentimentScore::NUMERIC,
    ALTER COLUMN sentimentMagnitude TYPE NUMERIC USING sentimentMagnitude::NUMERIC;


--ALL SESSIONS TABLE

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



--ANALYTICS TABLE

    --CREATE ANALYTICS TABLE
    --------------------------------------------------------------------------------
    CREATE TABLE analytics(
    	visitnumber VARCHAR,
    	visitid VARCHAR,
    	visitstarttime VARCHAR,
    	visitdate VARCHAR,
    	visitorid VARCHAR,
    	userid VARCHAR,
    	channelgrouping VARCHAR,
    	socialengagementtype VARCHAR,
    	unitsold VARCHAR,
    	pageviews VARCHAR,
    	timeonsite VARCHAR,
    	bounces VARCHAR,
    	revenue VARCHAR,
    	unitprice VARCHAR
    );
    
    -- INSERTING RAW DATA TO TABLE
    --------------------------------------------------------------------------------
    INSERT INTO analytics
    SELECT * 
    FROM raw_analytics
    OFFSET 1; --REMOVE FIRST ROW
    
    --ALTERING DATATYPE
    --------------------------------------------------------------------------------
    ALTER TABLE analytics
    ALTER COLUMN visitnumber TYPE VARCHAR,
    ALTER COLUMN visitid TYPE VARCHAR,
    ALTER COLUMN visitstarttime TYPE NUMERIC USING visitstarttime :: NUMERIC,
    ALTER COLUMN visitdate TYPE DATE USING visitdate :: DATE,
    ALTER COLUMN visitorid TYPE VARCHAR,
    ALTER COLUMN userid TYPE VARCHAR,
    ALTER COLUMN channelgrouping TYPE VARCHAR,
    ALTER COLUMN socialengagementtype TYPE VARCHAR,
    ALTER COLUMN unitsold TYPE NUMERIC USING unitsold :: NUMERIC,
    ALTER COLUMN pageviews TYPE NUMERIC USING pageviews :: NUMERIC,
    ALTER COLUMN timeonsite TYPE NUMERIC USING timeonsite :: NUMERIC,
    ALTER COLUMN bounces TYPE NUMERIC USING bounces :: NUMERIC,
    ALTER COLUMN revenue TYPE NUMERIC USING revenue :: NUMERIC,
    ALTER COLUMN unitprice TYPE NUMERIC USING unitprice :: NUMERIC;

    
--SALES REPORT TABLE

    --SALES REPOR TABLE
    --------------------------------------------------------------------------------
    CREATE TABLE sales_report(
    	productsku VARCHAR,
    	totalordered VARCHAR,
    	prodname VARCHAR,
    	stocklevel VARCHAR,
    	restockingleadtime VARCHAR,
    	sentimentscore VARCHAR,
    	sentimentmagnitude VARCHAR,
    	ratio VARCHAR
    );
    
    --INSERTING RAW TABLE
    --------------------------------------------------------------------------------
    INSERT INTO sales_report
    SELECT *
    FROM raw_sales_report
    OFFSET 1; --OFFSET 1 ROW
    
    --ALTERING TABLE DATATYPE
    --------------------------------------------------------------------------------
    ALTER TABLE sales_report
    ALTER COLUMN productsku TYPE VARCHAR,
    ALTER COLUMN totalordered TYPE NUMERIC USING totalordered :: NUMERIC,
    ALTER COLUMN prodname TYPE VARCHAR,
    ALTER COLUMN stocklevel TYPE NUMERIC USING stocklevel :: NUMERIC,
    ALTER COLUMN restockingleadtime TYPE NUMERIC USING restockingleadtime :: NUMERIC,
    ALTER COLUMN sentimentscore TYPE NUMERIC USING sentimentscore :: NUMERIC,
    ALTER COLUMN sentimentmagnitude TYPE NUMERIC USING sentimentmagnitude :: NUMERIC,
    ALTER COLUMN ratio TYPE NUMERIC USING ratio :: NUMERIC;


--SKU SALES TABLE

    --CREATING TABLE
    --------------------------------------------------------------------------------
    CREATE TABLE sku_sales(
    	productsku VARCHAR,
    	totalordered VARCHAR
    );
    
    --INSERTING DATA
    --------------------------------------------------------------------------------
    INSERT INTO sku_sales
    SELECT *
    FROM raw_sku_sales
    OFFSET 1; --OFFSET 1 ROW
    
    --ALTERING DATA TYPE
    --------------------------------------------------------------------------------
    ALTER TABLE sku_sales
    ALTER COLUMN productsku TYPE VARCHAR,
    ALTER COLUMN totalordered TYPE NUMERIC USING totalordered :: NUMERIC;


----------------------------------------------------------OOOOOOOOOOOOOOOOOOO--------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------------
2. Divide prices by 1000000
------------------------------------------------------------------------------------------------------------------------------------
    --CORRECTING ALL SESSIONS PRICES
    --------------------------------------------------------------------------------
    UPDATE all_sessions
    SET productprice = productprice / 1000000;
    UPDATE all_sessions
    SET productrevenue = productrevenue / 1000000;
    UPDATE all_sessions
    SET totaltransactionrevenue = totaltransactionrevenue / 1000000;
    UPDATE all_sessions
    SET transrevenue = transrevenue / 1000000;

     --CORRECTING ANALYTICS PRICES
     --------------------------------------------------------------------------------
    SELECT * 
    FROM analytics
    WHERE unitsold IS NOT NULL;
    
    UPDATE analytics
    SET unitprice = unitprice / 1000000;
----------------------------------------------------------OOOOOOOOOOOOOOOOOOO--------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------------
3. Update the values by removing unnessesary characters
------------------------------------------------------------------------------------------------------------------------------------
    ---CORRECTING PRODUCT CATEGORY
    --------------------------------------------------------------------------------
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
------------------------------------------------------------------------------------------------------------------------------------
