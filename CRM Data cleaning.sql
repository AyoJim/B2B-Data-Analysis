
	

--Seperate the names of the country using Left cleaning
SELECT "Office_location",LEFT("Office_location",7) AS Office
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product";

--Show the position of a string from the left
SELECT "Sector",
		"Office_location",
		POSITION (',' IN "Office_location") AS comma_position
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product";	

--Seperate the names of the country using Right cleaning
SELECT "Office_location",RIGHT("Office_location",7) AS Office
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product";

--Shows the length of the Sector column
SELECT LENGTH("Sector") AS Sub
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent";

--Show the position of a string from the left
SELECT Office,
		"Office_location",
		POSITION (',' IN "Office_location") AS comma_position
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product";	

--Combine Multiple Columns INTOONE/CONCAT
SELECT CONCAT("Revenue",' ',"Employees") AS revenue_employees
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product";	

--Combine Multiple Columns into one/Piping
SELECT "Revenue" ||' '|| "Employees" AS revenue_employees_alt
FROM public."Accounts"
JOIN public."Sales_pipeline"
ON public."Accounts"."Account" = public."Sales_pipeline"."Account"
JOIN public."Sales_team"
ON public."Sales_pipeline"."Sales_agent" = public."Sales_team"."Sales_agent"
JOIN public."Products"
ON public."Sales_pipeline"."Product" = public."Products"."Product";	

