# Final-Project-Transforming-and-Analyzing-Data-with-SQL

## Project/Goals
1. To upload csv files on pgadmin as raw tables with a universal data type
2. To create a cleaned table with the correct data type separate from the raw table
3. To clean the cleaned table first and as needed
4. To answer the five questions

## Process
1.1 Download the csv files and briefly scan the table
1.2 Use pgadmin's GUI to upload the csv files using VARCHAR data type to avoid compatibility issues
1.3 Use a raw prefix for the raw tables for easier identification

2.1 Create a new table with the same number of columns as it's raw table counterpart
2.2 Set all data type of the new table's columns to VARCHAR
2.3 Insert the raw table's value to the new table
2.4 Alter the new table's data type using the correct data type by looking at the raw table's data

3.1 Correct the price discrepancies by dividing all price related columns by 1000000
3.2 Clean the productcategory column by isolating the correct keyword 
3.2.1 Use update and set to correctly categorize the value
3.2.2 Use substrings for stubborn characters

4.1 Use CTEs, JOINS, Window and other techniques to answer the questions. 

## Results
(fill in what you discovered this data could tell you and how you used the data to answer those questions)
-This data showed the top categories, categories per country and cities with the highest total transaction revenue.

## Challenges 
-The lack of metadata
--Getting the totaltransactionrevenue

## Future Goals
- I would have get all the sku of the products that doesn't exist on the products table from other tables like sku_sales and all_sessions tables.
- I would have added more connections from the tables using foreign keys
