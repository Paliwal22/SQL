--SQL - Mobile manufacturer data analysis 


--Q1--List all the states in which we have customers who have bought cellphones from 2005 till today. 

	Select State from DIM_Location
	where IDLocation >= 2005

--Q2--What state in the US is buying the most 'Samsung' cell phones?

	Select TOP 5 State From DIM_LOCATION as DL
Inner join FACT_TRANSACTIONS as FT On DL.IDLocation = FT.IDLocation
Inner join DIM_MODEL as DM on FT.IDModel = Dm.IDModel
Inner join DIM_MANUFACTURER as DMF on DMF.IDManufacturer = DM.IDManufacturer
where Manufacturer_Name= 'Samsung'
Group by State
Order by Sum(Quantity) desc


--Q3-- Show the number of transactions for each model per zip code per state. 

	Select DIM_MODEL.Model_Name, DIM_LOCATION.State, DIM_LOCATION.ZipCode, Count(Quantity) as Number_of_transactions From FACT_TRANSACTIONS
Inner Join DIM_MODEL on DIM_MODEL.IDModel = FACT_TRANSACTIONS.IDModel
Inner join DIM_LOCATION on DIM_LOCATION.IDLocation = FACT_TRANSACTIONS.IDLocation
Group by DIM_MODEL.Model_Name, DIM_LOCATION.State, DIM_LOCATION.ZipCode 
Order By DIM_MODEL.Model_Name


--Q4-- Show the cheapest cellphone (Output should contain the price also)

Select * from DIM_MODEL

Select top 1 Model_Name, Min(Unit_price) From DIM_MODEL
Group By Model_Name


--Q5-- Find out the average price for each model in the top5 manufacturers in terms of sales quantity and order by average price. 

Select top 5 DIM_MANUFACTURER.Manufacturer_Name,DIM_MODEL.Model_Name ,SUM(Quantity) as Sales_Quantity, AVG(UNIT_PRICE) as PRICE from FACT_TRANSACTIONS
Inner Join  DIM_MODEL on DIM_MODEL.IDModel = FACT_TRANSACTIONS.IDModel
Inner Join DIM_MANUFACTURER on DIM_MANUFACTURER.IDManufacturer = DIM_MODEL.IDManufacturer
Group By DIM_MODEL.Model_Name,DIM_MANUFACTURER.Manufacturer_Name
Order by Sales_Quantity Desc


--Q6--List the names of the customers and the average amount spent in 2009, where the average is higher than 500 

Select DIM_CUSTOMER.Customer_Name , DIM_DATE.YEAR , AVG(FT.TotalPrice) as AvgPrice from FACT_TRANSACTIONS as FT
Inner Join DIM_CUSTOMER on FT.IDCustomer = DIM_CUSTOMER.IDCustomer
Inner Join DIM_DATE on FT.Date = DIM_DATE.DATE
Where DIM_DATE.YEAR = 2009
group by DIM_CUSTOMER.Customer_Name, DIM_DATE.YEAR
Having AVG(FT.TotalPrice) > 500

	
--Q7--List if there is any model that was in the top 5 in terms of quantity, simultaneously in 2008, 2009 and 2010 
	
Select * From DIM_MODEL
Select * from FACT_TRANSACTIONS
Select * from DIM_DATE

Select TOP 5(SUM(FT.Quantity)) as TotalQuantity , DIM_MODEL.Model_Name, DIM_DATE.YEAR from FACT_TRANSACTIONS as FT
Inner Join DIM_MODEL on DIM_MODEL.IDModel = FT.IDModel
Inner Join DIM_DATE on DIM_DATE.DATE = FT.Date
Where DIM_DATE.year in ('2008','2009','2010')
Group by  DIM_MODEL.Model_Name, DIM_DATE.YEAR
order by TotalQuantity desc	

	
--Q8--Show the manufacturer with the 2nd top sales in the year of 2009 and the manufacturer with the 2nd top sales in the year of 2010. 

WITH manufacturer_rank AS (
  SELECT
    dim_manufacturer.manufacturer_name,
    YEAR(fact_transactions.date) AS year,
    RANK() OVER (PARTITION BY YEAR(fact_transactions.date) ORDER BY SUM(fact_transactions.totalprice) DESC) AS rank
  FROM fact_transactions
  JOIN dim_model ON fact_transactions.idmodel = dim_model.idmodel
  JOIN dim_manufacturer ON dim_model.idmanufacturer = dim_manufacturer.idmanufacturer
  GROUP BY dim_manufacturer.manufacturer_name, YEAR(fact_transactions.date))

SELECT manufacturer_name, year
FROM manufacturer_rank
WHERE rank = 2 AND year IN (2009, 2010)


--Q9-- Show the manufacturers that sold cellphones in 2010 but did not in 2009.
	
Select Distinct DIM_MANUFACTURER.Manufacturer_Name From FACT_TRANSACTIONS
Inner Join DIM_MODEL on FACT_TRANSACTIONS.IDModel = DIM_MODEL.IDModel
Inner join DIM_MANUFACTURER on DIM_MODEL.IDManufacturer = DIM_MANUFACTURER.IDManufacturer
Where YEAR(Date) = 2010                                
Group by  DIM_MANUFACTURER.Manufacturer_Name 

Except 

Select Distinct DIM_MANUFACTURER.Manufacturer_Name From FACT_TRANSACTIONS
Inner Join DIM_MODEL on FACT_TRANSACTIONS.IDModel = DIM_MODEL.IDModel
Inner join DIM_MANUFACTURER on DIM_MODEL.IDManufacturer = DIM_MANUFACTURER.IDManufacturer
Where YEAR(Date) = 2009 
Group by  DIM_MANUFACTURER.Manufacturer_Name 


--Q10-- Find top 100 customers and their average spend, average quantity by each year. Also find the percentage of change in their spend.
	
Select * , ((Avg_Spending - lag_price)/lag_price) as percentage_change from 
	(Select *, LAG(Avg_Spending,1) over(partition by idcustomer order by  Trasnaction_Year) as lag_price from 
		(Select idcustomer, year(date) as Trasnaction_Year, AVG(totalprice) as Avg_Spending, SUM(quantity) as Total_Quantity from FACT_TRANSACTIONS
			Where IDCustomer in 
							(Select top 100 idcustomer from FACT_TRANSACTIONS
								Group by IDCustomer
								Order by sum(totalprice) Desc	)
			Group by IDCustomer, year(date)) as Y) as Z

	