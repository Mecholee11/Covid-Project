select*
from [Portfolio Project]..CovidDeaths
where continent is not null
order by 3,4

--select*
--from [Portfolio Project]..CovidVaccinations
--order by 3,4

select location,date,total_cases,new_cases,total_deaths,population
from [Portfolio Project]..CovidDeaths
order by 1,2


--Total Cases Vs Total Deaths

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 AS DeathPercentage
from [Portfolio Project]..CovidDeaths
where location like '%Nigeria%'
order by 1,2

--Total Cases Vs Population

select location,date,total_cases,population,(total_cases/population)*100 AS  PercentPopulationInfected
from [Portfolio Project]..CovidDeaths
--where location like '%Nigeria%'
order by 1,2 

-- Countries with Highest Infection Rate Vs Population

select location,population,date,MAX(total_cases) AS HighestInfectionCount,MAX((total_cases/population))*100 AS PercentPopulationInfected
from [Portfolio Project]..CovidDeaths
--where location like '%Nigerai%'
Group by location,population,date
order by  PercentPopulationInfected DESC


--Countries with Highest Death Count Per Population

select location,population,MAX(cast(total_deaths AS int)) AS TotaldeathCount
from [Portfolio Project]..CovidDeaths
--where location like '%Nigeria%'
where continent is not null
Group by location,population
Order by  TotaldeathCount DESC


select location,SUM(cast(new_deaths AS int)) AS TotaldeathCount
from [Portfolio Project]..CovidDeaths
--where location like '%Nigeria%'
where continent is null
and location not in ('world' , 'European Union' ,'International')
Group by location
Order by  TotaldeathCount DESC





-- CONTINENT WITH HIGHEST DEATH COUNT PER POPULATION


select continent,MAX(cast(total_deaths AS int)) AS TotaldeathCount
from [Portfolio Project]..CovidDeaths
--where location like '%Nigeria%'
where continent is not null
Group by continent
Order by  TotaldeathCount DESC

-- GLOBAL NUMBERS

select date, SUM(new_cases) AS Total_cases, SUM(cast(new_deaths AS int)) AS Total_deaths, SUM(cast(new_deaths AS int))/SUM(new_cases)*100 AS DeathPercentage
from [Portfolio Project]..CovidDeaths
--where location like '%Nigeria%'
where continent is not null
Group by date
order by 1,2

select SUM(new_cases) AS Total_cases, SUM(cast(new_deaths AS int)) AS Total_deaths, SUM(cast(new_deaths AS int))/SUM(new_cases)*100 AS DeathPercentage
from [Portfolio Project]..CovidDeaths
--where location like '%Nigeria%'
where continent is not null
--Group by date
order by 1,2


select *
from [Portfolio Project]..CovidDeaths dea
JOIN [Portfolio Project]..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date


	--Total Population Vs Vaccination
	
	select dea.continent,dea.date,dea.location,dea.population,vac.new_vaccinations
	from [Portfolio Project]..CovidDeaths dea
JOIN [Portfolio Project]..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
	WHERE dea.continent is not null
	ORDER BY 3,4

	
	select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
	SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date) AS VaccinatedPeopleRolling
	from [Portfolio Project]..CovidDeaths dea
	JOIN [Portfolio Project]..CovidVaccinations vac
		ON dea.location = vac.location
	AND dea.date = vac.date
	WHERE dea.continent is not null
	ORDER BY 2,3

	--USING CTE

	With PopulationVSVaccination (Continent,Location,Date,Population,New_Vaccinations,VaccinatedPeopleRolling)AS
	(
	select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
	SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date) AS VaccinatedPeopleRolling
	--,(VaccinatedPeopleRolling/Population)*100
	from [Portfolio Project]..CovidDeaths dea
	JOIN [Portfolio Project]..CovidVaccinations vac
		ON dea.location = vac.location
	AND dea.date = vac.date
	WHERE dea.continent is not null
	--ORDER BY 2,3
	)
	Select * , (VaccinatedPeopleRolling/Population)*100
	from PopulationVSVaccination

	-- USING TEMP TABLE
	

	Create Table #PercentPopulationVaccinated
	(
	Continent nvarchar(255),
	Location nvarchar(255),
	Date datetime,
	Population numeric,
	New_vaccination numeric,
	VaccinatedPeopleRolling numeric
	)

	Insert into #PercentPopulationVaccinated

	select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
	SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date) AS VaccinatedPeopleRolling
	--,(VaccinatedPeopleRolling/Population)*100
	from [Portfolio Project]..CovidDeaths dea
	JOIN [Portfolio Project]..CovidVaccinations vac
		ON dea.location = vac.location
	AND dea.date = vac.date
	WHERE dea.continent is not null
	--ORDER BY 2,3
	
	Select * , (VaccinatedPeopleRolling/Population)*100
	from #PercentPopulationVaccinated 


	--Creating view for visualizations

	

	
	
	DROP VIEW IF EXISTS PercentPopulationVaccinated;
GO

CREATE VIEW PercentPopulationVaccinated AS
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(CONVERT(int, vac.new_vaccinations)) OVER (
        PARTITION BY dea.location 
        ORDER BY dea.location, dea.date
    ) AS VaccinatedPeopleRolling
FROM [Portfolio Project]..CovidDeaths dea
JOIN [Portfolio Project]..CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;
GO