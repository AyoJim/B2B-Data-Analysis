--Select all the data in each table
--Select all the data in the "Accounts" table
SELECT * 
FROM public."Accounts";

--Select all the data in the "Sales_pipeline" table
SELECT * 
FROM public."Sales_pipeline";

--Select all the data in the "Sales_team" table
SELECT * 
FROM public."Sales_team";

--Select all the data in the "Products" table
SELECT * 
FROM public."Products";

--Update Null values 
UPDATE public."Sales_pipeline"
SET "Close_value"=0
WHERE "Close_value" IS NULL;

--Update Null to None for "Subsidiary_of" column of the Accounts table
UPDATE public."Accounts"
SET "Subsidiary_of"='None'
WHERE "Subsidiary_of" IS NULL;

--Update Null to '1900-01-01' for "Close_date" column of the Accounts table
UPDATE public."Sales_pipeline"
SET "Close_date"='1900-01-01'
WHERE "Close_date" IS NULL;

--Update Null to '1900-01-01' for "Engage_date" column of the Accounts table
UPDATE public."Sales_pipeline"
SET "Engage_date"='1900-01-01'
WHERE "Engage_date" IS NULL;


UPDATE public."Accounts"
SET "Subsidiary_of" = REPLACE("Subsidiary_of",'0','Nil');

SELECT *
     , coalesce("Subsidiary_of", 'None')
FROM public."Accounts";

--Show all the sales agent that lost deals
SELECT DISTINCT "Sales_agent", "Deal_stage"
FROM public."Sales_pipeline"
WHERE "Deal_stage" LIKE '%Lost%';

--Show the number of deals each sales agent lost
SELECT "Sales_agent", COUNT("Sales_agent")
FROM public."Sales_pipeline"
WHERE "Deal_stage" LIKE '%Lost%'
GROUP BY "Sales_agent"
ORDER BY COUNT("Sales_agent") DESC;

--Show all the sales agent that won deals
SELECT DISTINCT "Sales_agent", "Deal_stage"
FROM public."Sales_pipeline"
WHERE "Deal_stage" LIKE '%Won%';

--Show the number of deals each sales agent won
SELECT "Sales_agent", COUNT("Sales_agent")
FROM public."Sales_pipeline"
WHERE "Deal_stage" LIKE '%Won%'
GROUP BY "Sales_agent"
ORDER BY COUNT("Sales_agent") DESC;

--The close_value and product for each deal successfully closed
SELECT DISTINCT "Product", "Close_value"
FROM public."Sales_pipeline"
WHERE "Deal_stage" LIKE '%Won%'
ORDER BY "Close_value" DESC;

--Show the count of the number of deals won for each product
SELECT "Product", COUNT("Product")
FROM public."Sales_pipeline"
WHERE "Deal_stage" LIKE '%Won%'
GROUP BY "Product"
ORDER BY COUNT("Product") DESC;

--Join the four tables
SELECT *
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product";

--Select all data in the combined table
SELECT *
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product";

--Statistical summary for revenue and close_value
SELECT SUM("Revenue") AS SUMRevenue,
		AVG("Revenue") AS AVGRevenue,
		MAX("Revenue") AS MINRevenue,
		MIN("Revenue") AS MINRevenue,
		SUM("Close_value") AS SUMClose_value,
		AVG("Close_value") AS AVGClose_value,
		MAX("Close_value") AS MAXClose_value,
		MIN("Close_value") AS MINClose_value
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product";

--Maximium & minimium revenue & close_value for each sector in a year
SELECT "Sector",
		"Year_established",
		MAX("Revenue") AS MINRevenue,
		MIN("Revenue") AS MINRevenue,
		MAX("Close_value") AS MAXClose_value,
		MIN("Close_value") AS MINClose_value
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
GROUP BY "Sector", "Year_established";

--Select all the accounts for the highest revenue
SELECT *
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
ORDER BY "Revenue" DESC
LIMIT 1;

--Select all the accounts for the highest close_value
SELECT *
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
ORDER BY "Close_value" DESC
LIMIT 1;

--Show the sector with the highest revenue
SELECT "Sector",
		"Revenue"
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
GROUP BY "Sector", "Revenue"
ORDER BY "Revenue" DESC;

--Select all the accounts for the top ten revenues 
--will interpret product, year, sector where revenue was highest--
SELECT *
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
WHERE "Close_value" > 1000
ORDER BY "Revenue" DESC
LIMIT 10;

--Select all data when the deal stage is won
SELECT *
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
WHERE "Deal_stage" LIKE '%Won%'
ORDER BY "Close_value" DESC;

--Select all data when the deal stage is engaging
SELECT *
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
WHERE "Deal_stage" LIKE '%Engaging%'
ORDER BY "Revenue" DESC;

--Select all data when the deal stage is lost
SELECT *
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
WHERE "Deal_stage" LIKE '%Lost%'
ORDER BY "Revenue" DESC;

--Sort all data from the "software" sector by revenue in descending order 
SELECT *
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
WHERE "Sector" LIKE '%software%'
ORDER BY "Revenue" DESC;

--Sort all data from all sector excluding "software" sector based on revenue in descending order
SELECT *
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
WHERE "Sector" NOT LIKE '%software%'
ORDER BY "Revenue" DESC;

--Total revenue for the "finance" sector
SELECT SUM("Revenue")
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
WHERE "Sector" LIKE '%finance%';

--Total revenue for the "software" sector
SELECT SUM("Revenue")
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
WHERE "Sector" LIKE '%software%';

--Total revenue for the "technology" sector
SELECT SUM("Revenue")
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
WHERE "Sector" LIKE '%technolgy%';

--Total revenue & close_value for "finance" sector
SELECT SUM("Revenue") AS SUMRevenue,
		SUM("Close_value") AS SUMClose_value
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
WHERE "Sector" LIKE '%finance%';

--Total revenue and close_value for each team
SELECT "Manager",
		SUM("Revenue") AS SUMREV,
		SUM("Close_value") AS SUMC_v
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
GROUP BY "Manager"
ORDER BY SUMREV DESC;

--Total revenue for each sector 
SELECT "Sector",
		SUM("Revenue") AS sum_revenue
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
GROUP BY "Sector"
HAVING SUM("Revenue") >= 2000;

--No of null values in "Subsidiary_of" column: Diff Between Count & No of rows 
SELECT COUNT ("Subsidiary_of")
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product";

--Query the table
SELECT "Sector",
	AVG(account_count) AS avg_account_count
FROM 
	(SELECT "Deal_stage",
	 		"Sector",
	 		COUNT(*) AS account_count
	FROM public."Accounts"
	JOIN public."Sales_pipeline"
	ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
	JOIN public."Sales_team"
	ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
	JOIN public."Products"
	ON public."Sales_pipeline"."Product" = public."Products"."Product"
	GROUP BY "Deal_stage",
			"Sector"
	ORDER BY "Deal_stage"
			) sub
			GROUP BY "Deal_stage", "Sector"
			ORDER BY "Sector";






