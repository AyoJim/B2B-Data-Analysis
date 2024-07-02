
--Row Number 
SELECT "Sector", 
		"Revenue", 
		"Year_established", 
		"Office_location",
		ROW_NUMBER() OVER (PARTITION BY "Office_location"
		ORDER BY "Year_established") AS row_num
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product";	

--Rank 
SELECT "Sector", 
		"Revenue", 
		"Year_established", 
		"Office_location",
		RANK() OVER (PARTITION BY "Office_location"
		ORDER BY "Revenue" DESC) AS revenue_rank
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product";	

--Compare rows
--Lag Functions
SELECT "Sector", standard_sum,
		LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag
FROM(
SELECT "Sector", SUM("Revenue") AS standard_sum
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
GROUP BY "Sector"
	)Sub;

--Lag difference
SELECT "Sector", standard_sum,
		LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag,
		standard_sum - LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag_difference
FROM(
SELECT "Sector", SUM("Revenue") AS standard_sum
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
GROUP BY "Sector"
	)Sub;

--Lead Function
SELECT "Sector", standard_sum,
		LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead
FROM(
SELECT "Sector", SUM("Revenue") AS standard_sum
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
GROUP BY "Sector"
	)Sub;

--Lead difference
SELECT "Sector", standard_sum,
		LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead,
		standard_sum - LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead_difference
FROM(
SELECT "Sector", SUM("Revenue") AS standard_sum
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
GROUP BY "Sector"
	)Sub;

--Percentiles
SELECT "Account", 
		"Revenue",
		"Employees",
		NTILE(4) OVER (ORDER BY "Revenue") AS quartile,
		NTILE(5) OVER (ORDER BY "Revenue") AS quintile,
		NTILE(100) OVER (ORDER BY "Revenue") AS percentile
FROM public."Accounts"
ORDER BY "Revenue" DESC; 


SELECT "Sector",
		"Revenue",
		"Employees",
		NTILE(4) OVER (ORDER BY "Revenue") AS quartile,
		NTILE(5) OVER (ORDER BY "Revenue") AS quintile,
		NTILE(100) OVER (ORDER BY "Revenue") AS percentile
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
ORDER BY "Revenue" DESC; 

SELECT "Sales_agent", 
		"Deal_stage",
		"Engage_date"
FROM public."Sales_pipeline"; 


--Aggregate the sector and group it based on revenue categories
SELECT CASE WHEN "Revenue" > 5000 THEN 'Over 5000'
			ELSE '5000 or under' END AS
				Revenue_group,
			COUNT(*)AS a_count,
			"Sector"
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product"
GROUP BY "Revenue", "Sector";
