CREATE TABLE CovidDeaths
(
	iso_code VARCHAR(120),
	continent VARCHAR(120),
	location VARCHAR(120),
	date date,
	population DECIMAL(20,2),
	total_cases DECIMAL(20,2),
	new_cases DECIMAL(20,2),
	new_cases_smoothed DECIMAL(20,2),
	total_deaths DECIMAL(20,2),
	new_deaths DECIMAL(20,2),
	new_deaths_smoothed DECIMAL(20,2),
	total_cases_per_million DECIMAL(20,2),
	new_cases_per_million DECIMAL(20,2),
	new_cases_smoothed_per_million DECIMAL(20,2),
	total_deaths_per_million DECIMAL(20,2),
	new_deaths_per_million DECIMAL(20,2),
	new_deaths_smoothed_per_million DECIMAL(20,2),
	reproduction_rate DECIMAL(20,2),
	icu_patients DECIMAL(20,2),
	icu_patients_per_million DECIMAL(20,2),
	hosp_patients DECIMAL(20,2),
	hosp_patients_per_million DECIMAL(20,2),
	weekly_icu_admissions DECIMAL(20,2),
	weekly_icu_admissions_per_million DECIMAL(20,2),
	weekly_hosp_admissions DECIMAL(20,2),
	weekly_hosp_admissions_per_million DECIMAL(20,2)
);

SELECT *
FROM coviddeaths
ORDER BY 3,4;
