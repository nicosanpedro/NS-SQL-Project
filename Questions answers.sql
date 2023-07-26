--Questions

-------------------------------------------------------------------------------------------------------------------------------
--1. Which cities and countries have the highest level of transaction revenues on the site?
-------------------------------------------------------------------------------------------------------------------------------
WITH cte_unitsold AS(
	SELECT
		country,
		city,
		productsku,
		totaltransactionrevenue, 
		transrevenue, 
		productprice, 
		productrevenue, 
		itemquantity, 
		itemrevenue,
		unitsold,
		visitnumber,
		ana.unitprice
	FROM
		all_sessions AS als
	LEFT JOIN
		analytics AS ana
	ON
		als.visitorid = ana.visitorid
	WHERE totaltransactionrevenue IS NOT NULL OR 
		productrevenue IS NOT NULL OR
		transrevenue IS NOT NULL
	ORDER BY totaltransactionrevenue DESC
)

SELECT cte_unitsold.country, cte_unitsold.city, cte_unitsold.totaltransactionrevenue
FROM cte_unitsold

-------------------------------------------------------------------------------------------------------------------------------
--2. What is the average number of products ordered from visitors in each city and country?
-------------------------------------------------------------------------------------------------------------------------------
WITH cte_orderS AS(
	SELECT 
		visitorid,
		country,
		city,
		als.productsku,
		totalordered
	FROM 
		all_sessions AS als
	JOIN 
		sales_report AS sre
	ON 
		als.productsku = sre.productsku
	WHERE totalordered IS NOT NULL AND country != '(not set)'
)

SELECT country, city, AVG(totalordered) AS averageordered
FROM cte_orders
GROUP BY country, city
ORDER BY COUNTRY ASC

-------------------------------------------------------------------------------------------------------------------------------
--3. Is there any pattern in the types (product categories) of products ordered from visitors in each city and country?
-------------------------------------------------------------------------------------------------------------------------------
WITH ranked_countries AS (
    SELECT 
        visitorid,
        country,
        city,
        productcategory,
        COUNT(productcategory) AS productcatcount,
        ROW_NUMBER() OVER(PARTITION BY country ORDER BY COUNT(productcategory) DESC) as row_num
    FROM 
        all_sessions
    WHERE 
        country != '(not set)' AND
        productcategory != '(not set)'
    GROUP BY 
        visitorid, country, city, productcategory
)
SELECT 
    visitorid,
    country,
    city,
    productcategory,
    productcatcount
FROM 
    ranked_countries
ORDER BY 
    country ASC, productcatcount DESC;

--


-------------------------------------------------------------------------------------------------------------------------------
--4. What is the top-selling product from each city/country? Can we find any pattern worthy of noting in the products sold?
-------------------------------------------------------------------------------------------------------------------------------
WITH ranked_countries AS (
    SELECT 
        visitorid,
        country,
        productcategory,
        COUNT(productcategory) AS productcatcount,
        ROW_NUMBER() OVER(PARTITION BY country ORDER BY COUNT(productcategory) DESC) as row_num
    FROM 
        all_sessions
    WHERE 
        country != '(not set)' AND
        productcategory != '(not set)'
    GROUP BY 
        visitorid, country, productcategory
)
SELECT 
    country,
    productcategory,
    productcatcount
FROM 
    ranked_countries
WHERE 
    row_num <= 1
ORDER BY 
    country ASC, productcatcount DESC;

-----------------------------------------------------------------------------------------------
--5. Can we summarize the impact of revenue generated from each city/country?
-----------------------------------------------------------------------------------------------

WITH cte_unitsold AS(
	SELECT
		country,
		city,
		productsku,
		totaltransactionrevenue, 
		transrevenue, 
		productprice, 
		productrevenue, 
		itemquantity, 
		itemrevenue,
		unitsold,
		visitnumber,
		ana.unitprice,
		productcategory
	FROM
		all_sessions AS als
	LEFT JOIN
		analytics AS ana
	ON
		als.visitorid = ana.visitorid
	WHERE totaltransactionrevenue IS NOT NULL OR 
		productrevenue IS NOT NULL OR
		transrevenue IS NOT NULL
	ORDER BY totaltransactionrevenue DESC
)

SELECT cte_unitsold.country, cte_unitsold.city, cte_unitsold.totaltransactionrevenue, cte_unitsold.productcategory
FROM cte_unitsold


