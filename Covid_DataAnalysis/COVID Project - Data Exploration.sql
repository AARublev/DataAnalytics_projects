SELECT * FROM coviddeaths
WHERE continent IS NOT NULL
ORDER BY 3,4;

SELECT * FROM covidvaccinations
WHERE continent IS NOT NULL
ORDER BY 3,4;

-- Select the data to start the work
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM coviddeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Total cases VS total deaths as a percentage in Russia
SELECT location, date, total_cases, total_deaths, ROUND(total_deaths/(NULLIF(total_cases, 0))*100,2) AS Deaths_percent
FROM coviddeaths
WHERE location LIKE '%ussia%'
  AND continent IS NOT NULL
ORDER BY 1,2;

-- Total Cases vs Population in Russia or in all countries
SELECT location, date, population, total_cases, (total_cases/population)*100 AS Infected_populations_precent
FROM coviddeaths
WHERE continent IS NOT NULL
--AND location LIKE '%ussia%'
ORDER BY 1,2;

-- Countries with Highest Infection Rate compared to Population
SELECT location, MAX(total_cases) AS highest_infection_count, MAX((total_cases/population)*100) AS Infected_populations_precent
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY Infected_populations_precent DESC;

-- Countries with Highest Death Count per population
SELECT location, MAX(total_deaths) AS highest_deaths_count
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY highest_deaths_count DESC;

/* Breakdown by continent
   continents with the highest mortality rate per population
 */
SELECT location, MAX(total_deaths) AS highest_deaths_count
FROM coviddeaths
WHERE continent IS NULL
GROUP BY location
ORDER BY highest_deaths_count DESC;

-- Global numbers
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, (SUM(new_deaths)/SUM(new_cases))*100 AS Deaths_percent
FROM coviddeaths
WHERE continent IS NOT NULL
--AND location LIKE '%ussia%'
--GROUP BY date
ORDER BY 1;

/*Total population in comparison with vaccinations
  Shows the percentage of the population that has received at least one Covid vaccine*/
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
       SUM(cv.new_vaccinations) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS Rolling_People_Vaccinated
FROM coviddeaths cd
JOIN covidvaccinations cv on cd .location = cv.location AND cd.date = cv.date
WHERE cd.continent is not NULL
--AND cd.location LIKE '%ussia%'
ORDER BY 1, 2, 3;

--Using CTE to perform the "Rolling_People_Vaccinated" calculation
WITH PopvsVac (continent, location, date, population, new_vaccinations, Rolling_People_Vaccinated)
AS
(
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
       SUM(cv.new_vaccinations) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS Rolling_People_Vaccinated
FROM coviddeaths cd
JOIN covidvaccinations cv on cd .location = cv.location AND cd.date = cv.date
WHERE cd.continent is not NULL
--AND cd.location LIKE '%ussia%'
)
SELECT *, (Rolling_People_Vaccinated/population)*100 AS vaccinated_populations_precent
FROM PopvsVac;

--Create temp table
DROP TABLE IF EXISTS PercentPopulationVaccinated;
CREATE TABLE PercentPopulationVaccinated
(
    Continent VARCHAR(120),
    Location VARCHAR(120),
    Date DATE,
    Population NUMERIC,
    New_vaccinations NUMERIC,
    Rolling_People_Vaccinated NUMERIC
);

INSERT INTO PercentPopulationVaccinated
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
       SUM(cv.new_vaccinations) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS Rolling_People_Vaccinated
FROM coviddeaths cd
JOIN covidvaccinations cv on cd .location = cv.location AND cd.date = cv.date
--WHERE cd.continent is not NULL;
--AND cd.location LIKE '%ussia%'

SELECT *, (Rolling_People_Vaccinated/population)*100 AS vaccinated_populations_precent
FROM PercentPopulationVaccinated;

--creating view to store date four later visualizations
CREATE VIEW Percent_Population_Vaccinated AS
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
       SUM(cv.new_vaccinations) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS Rolling_People_Vaccinated
FROM coviddeaths cd
JOIN covidvaccinations cv on cd .location = cv.location AND cd.date = cv.date
WHERE cd.continent is not NULL;
--AND cd.location LIKE '%ussia%'

SELECT *
FROM Percent_Population_Vaccinated;