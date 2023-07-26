--DROP TABLE raw_analytics

--RAW ANALYTICS TABLE
SELECT * 
FROM raw_analytics

--------------------------------------------------------------------------------
--ANALYTICS TABLE
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

--------------------------------------------------------------------------------
-- INSERTING RAW DATA TO TABLE
--------------------------------------------------------------------------------
INSERT INTO analytics
SELECT * 
FROM raw_analytics
OFFSET 1; --REMOVE FIRST ROW

--------------------------------------------------------------------------------
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


--------------------------------------------------------------------------------
---CORRECTING PRICE
--------------------------------------------------------------------------------
--1. ANALYTICS
SELECT * 
FROM analytics
WHERE unitsold IS NOT NULL;

UPDATE analytics
SET unitprice = unitprice / 1000000;


--------------------------------------------------------------------------------
--CREATING PRIMARY KEYS
--------------------------------------------------------------------------------

--ANALYTICS PK
ALTER TABLE analytics
ADD COLUMN analyticsid VARCHAR,
ADD COLUMN analyticsnum SERIAL,
ADD COLUMN analyticstext VARCHAR DEFAULT 'A';

UPDATE analytics
SET analyticsid = analyticstext || analyticsnum :: VARCHAR;

ALTER TABLE analytics
DROP COLUMN analyticsnum,
DROP COLUMN analyticstext,
ADD PRIMARY KEY(analyticsid);

