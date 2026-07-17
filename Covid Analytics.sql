USE Covid_Analytics;
GO

-- 1. Global totals
SELECT 
    SUM(New_cases) AS Total_New_Cases,
    SUM(New_deaths) AS Total_New_Deaths,
    MAX(Cumulative_cases) AS Latest_Cumulative_Cases,
    MAX(Cumulative_deaths) AS Latest_Cumulative_Deaths
FROM [WHO COVID-19 cases];

-- 2. Top 10 countries by total cases
SELECT TOP 10
    Country,
    MAX(Cumulative_cases) AS Total_Cases,
    MAX(Cumulative_deaths) AS Total_Deaths
FROM [WHO COVID-19 cases]
GROUP BY Country
ORDER BY Total_Cases DESC;

-- 3. Cases by WHO Region
SELECT 
    WHO_region,
    SUM(New_cases) AS Total_Cases,
    SUM(New_deaths) AS Total_Deaths
FROM [WHO COVID-19 cases]
GROUP BY WHO_region
ORDER BY Total_Cases DESC;

-- 4. Case Fatality Rate by Country (top 10)
SELECT TOP 10
    Country,
    MAX(Cumulative_cases) AS Total_Cases,
    MAX(Cumulative_deaths) AS Total_Deaths,
    CAST(MAX(Cumulative_deaths) * 100.0 / NULLIF(MAX(Cumulative_cases), 0) AS DECIMAL(5,2)) AS Fatality_Rate_Pct
FROM [WHO COVID-19 cases]
GROUP BY Country
HAVING MAX(Cumulative_cases) > 100000
ORDER BY Total_Cases DESC;

-- 5. Monthly trend
SELECT 
    FORMAT(CAST(Date_reported AS DATE), 'yyyy-MM') AS Year_Month,
    SUM(New_cases) AS Monthly_Cases,
    SUM(New_deaths) AS Monthly_Deaths
FROM [WHO COVID-19 cases]
GROUP BY FORMAT(CAST(Date_reported AS DATE), 'yyyy-MM')
ORDER BY Year_Month;

-- 6. Cases by Continent
SELECT 
    Continent,
    SUM(New_cases) AS Total_Cases,
    SUM(New_deaths) AS Total_Deaths
FROM [WHO COVID-19 cases]
GROUP BY Continent
ORDER BY Total_Cases DESC;

-- 7. Peak single-day case count per country (top 10)
SELECT TOP 10
    Country,
    MAX(New_cases) AS Peak_Daily_Cases
FROM [WHO COVID-19 cases]
GROUP BY Country
ORDER BY Peak_Daily_Cases DESC;

-- 8. Countries with highest fatality rate
SELECT TOP 10
    Country,
    MAX(Cumulative_cases) AS Total_Cases,
    MAX(Cumulative_deaths) AS Total_Deaths,
    CAST(MAX(Cumulative_deaths) * 100.0 / NULLIF(MAX(Cumulative_cases), 0) AS DECIMAL(5,2)) AS Fatality_Rate_Pct
FROM [WHO COVID-19 cases]
GROUP BY Country
HAVING MAX(Cumulative_cases) > 50000
ORDER BY Fatality_Rate_Pct DESC;