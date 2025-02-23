# SQL: Mobile Manufacturer Data Analysis
<br>
This project focuses on analyzing the sales data of mobile manufacturers to gain insights into sales trends, model performance, and customer preferences. The analysis leverages SQL queries to retrieve, filter, and aggregate data across various dimensions, such as manufacturers, models, locations, and time periods.

Objectives :-
<br>
Understanding the performance of different manufacturers and models.
<br>
Analyzing sales trends and customer demographics over time.
<br>
Using advanced SQL techniques like joins, window functions, and CTEs to handle complex queries and deliver insightful reports.

The project covers various tasks, including :-
<br>
Basic data retrieval and filtering.
<br>
Aggregating sales data for manufacturers and models.
<br>
Using advanced SQL functions to analyze time-based trends and rank performance.
<br>
This analysis aims to help businesses optimize their strategies by understanding which models perform best, customer buying behavior, and geographical trends.
<br>
Understanding the Data Structure:

Identify key tables (e.g., Dim_manufacturer, Dim_model, Dim_customer, Dim_Location, Fact_Transactions) and understand the relationships between them, using primary and foreign keys.
Examine Table Structure: Ensure that each table’s purpose is clear, and the relationships between tables (like linking manufacturer data to transaction data) are understood.
<br>
Basic Q1 & Q4 :Simple SELECT Queries: Write basic SQL queries to retrieve relevant data based on specific criteria.
<br>
Joining Tables for Complex Queries (Q2, Q3, Q5, Q6, Q8, Q9):-
<br>
Aggregation: Apply aggregate functions like SUM(), AVG(), and COUNT() to summarize sales data.
GROUP BY: Use GROUP BY to group results based on key dimensions (e.g., state, model, manufacturer) for deeper analysis.
Filtering and Ordering Results 
WHERE: Use the WHERE clause to filter data based on specific conditions (e.g., location, sales threshold).
ORDER BY: Sort results based on specific criteria, such as sales figures or model popularity.
TOP: Limit the number of rows returned to focus on the most relevant data
<br>
Advanced Techniques (Q7, Q8, Q9, Q10):
<br>
WITH Clauses (CTEs): Use Common Table Expressions (CTEs) for organizing complex queries (Q8).
Window Functions: Use RANK() and LAG() to analyze rankings and calculate percentage changes over time.
EXCEPT: Use EXCEPT to find manufacturers that appear in one year but not another (Q9).
Subqueries: Use subqueries for filtering based on results from other queries (Q10).
Analyzing Time-Based Trends (Q1, Q6, Q7, Q8, Q9, Q10)
