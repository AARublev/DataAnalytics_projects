CREATE TABLE CovidVaccinations
(
        iso_code VARCHAR(120),
        continent VARCHAR(120),
        location VARCHAR(120),
        date DATE,
        total_tests DECIMAL(20,2),
        new_tests DECIMAL(20,2),
        total_tests_per_thousand DECIMAL(20,2),
        new_tests_per_thousand DECIMAL(20,2),
        new_tests_smoothed DECIMAL(20,2),
        new_tests_smoothed_per_thousand DECIMAL(20,2),
        positive_rate DECIMAL(20,2),
        tests_per_case DECIMAL(20,2),
        tests_units VARCHAR(120),
        total_vaccinations DECIMAL(20,2),
        people_vaccinated DECIMAL(20,2),
        people_fully_vaccinated DECIMAL(20,2),
        total_boosters DECIMAL(20,2),
        new_vaccinations DECIMAL(20,2),
        new_vaccinations_smoothed DECIMAL(20,2),
        total_vaccinations_per_hundred DECIMAL(20,2),
        people_vaccinated_per_hundred DECIMAL(20,2),
        people_fully_vaccinated_per_hundred DECIMAL(20,2),
        total_boosters_per_hundred DECIMAL(20,2),
        new_vaccinations_smoothed_per_million DECIMAL(20,2),
        new_people_vaccinated_smoothed DECIMAL(20,2),
        new_people_vaccinated_smoothed_per_hundred DECIMAL(20,2),
        stringency_index DECIMAL(20,2),
        population_density DECIMAL(20,2),
        median_age DECIMAL(20,2),
        aged_65_older DECIMAL(20,2),
        aged_70_older DECIMAL(20,2),
        gdp_per_capita DECIMAL(20,2),
        extreme_poverty DECIMAL(20,2),
        cardiovasc_death_rate DECIMAL(20,2),
        diabetes_prevalence DECIMAL(20,2),
        female_smokers DECIMAL(20,2),
        male_smokers DECIMAL(20,2),
        handwashing_facilities DECIMAL(20,2),
        hospital_beds_per_thousand DECIMAL(20,2),
        life_expectancy DECIMAL(20,2),
        human_development_index DECIMAL(20,2),
        excess_mortality_cumulative_absolute DECIMAL(20,2),
        excess_mortality_cumulative DECIMAL(20,2),
        excess_mortality DECIMAL(20,2),
        excess_mortality_cumulative_per_million DECIMAL(20,2)
);

SELECT *
FROM covidvaccinations
ORDER BY 3,4;
