-- Retail sales analysis
-- If your imported table has a different name, replace it below.

-- 1. Overall KPIs
SELECT
    SUM([Total Amount]) AS total_revenue,
    COUNT(DISTINCT [Transaction ID]) AS transaction_count,
    CAST(
        SUM([Total Amount]) * 1.0
        / NULLIF(COUNT(DISTINCT [Transaction ID]), 0)
        AS DECIMAL(10, 2)
    ) AS average_transaction_value
FROM dbo.retail_sales_dataset2edited;

-- 2. Revenue by month
SELECT
    YEAR(TRY_CONVERT(date, [Date])) AS sales_year,
    MONTH(TRY_CONVERT(date, [Date])) AS sales_month,
    SUM([Total Amount]) AS revenue
FROM dbo.retail_sales_dataset2edited
GROUP BY
    YEAR(TRY_CONVERT(date, [Date])),
    MONTH(TRY_CONVERT(date, [Date]))
ORDER BY sales_year, sales_month;

-- 3. Revenue by product category
SELECT
    [Product Category],
    SUM([Total Amount]) AS revenue
FROM dbo.retail_sales_dataset2edited
GROUP BY [Product Category]
ORDER BY revenue DESC;

-- 4. Revenue by gender
SELECT
    Gender,
    SUM([Total Amount]) AS revenue
FROM dbo.retail_sales_dataset2edited
GROUP BY Gender
ORDER BY revenue DESC;

-- 5. Revenue by age group
SELECT
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        WHEN Age >= 56 THEN '56+'
        ELSE 'Unknown'
    END AS age_group,
    SUM([Total Amount]) AS revenue
FROM dbo.retail_sales_dataset2edited
GROUP BY
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        WHEN Age >= 56 THEN '56+'
        ELSE 'Unknown'
    END
ORDER BY revenue DESC;