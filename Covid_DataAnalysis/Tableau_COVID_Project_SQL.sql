/*
Queries used for Tableau Project
*/

-- 1
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, (SUM(new_deaths )/SUM(new_cases))*100 AS death_percentage
FROM CovidDeaths
--Where location like '%ussia%'
WHERE continent IS NOT NULL
--Group By date
ORDER BY 1,2;


-- 2
SELECT location, SUM(new_deaths) AS Total_Death_Count
FROM CovidDeaths
--Where location like '%ussia%'
WHERE continent IS NULL
AND location NOT IN('World', 'European Union', 'International')
AND location NOT LIKE '%income%'
GROUP BY location
ORDER BY Total_Death_Count DESC;


-- 3
SELECT location, population, MAX(total_cases) AS Highest_Infection_Count,  MAX((total_cases/population)*100) AS Infected_populations_precent
FROM CovidDeaths
--Where location like '%ussia%'
WHERE continent IS NOT NULL
GROUP BY Location, Population
ORDER BY Infected_populations_precent DESC;


-- 4
SELECT location, population, date, MAX(total_cases) as Highest_Infection_Count,  MAX((total_cases/population)*100) AS Infected_populations_precent
FROM CovidDeaths
--Where location like '%ussia%'
WHERE continent IS NOT NULL AND location = 'Russia'
GROUP BY Location, population, date
ORDER BY Infected_populations_precent DESC;





