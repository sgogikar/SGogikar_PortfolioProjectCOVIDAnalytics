select *
from PortfolioProject..CovidDeaths
order by 3,4

--select *
--from PortfolioProject..CovidVaccinations	
--order by 3,4

-- i'm now going to select the data that will be used 

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

-- lte's take a look at total cases Vs Total deaths [basically calculating the percentage of people who died]
-- and may be look into death percentage in India

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%India%'
order by 1,2

--now let's take a look at Total cases Vs Population 
-- to show 'what % of people got covid' in the selected Location. 
select location, date,population, total_cases,  (total_cases/population)*100 as PercentageOfPopulation_Affected 
from PortfolioProject..CovidDeaths
where location like '%Australia%'
order by 1,2

--let us take a look at countries with highest infection rate compared to population, "grouped & ordered in a descending fashion"
select location, population, MAX(total_cases) AS Highest_Infection_Count,  MAX((total_cases/population))*100 as PercentageOfPopulation_Affected 
from PortfolioProject..CovidDeaths
--where location like '%Australia%'
group by location, population
order by PercentageOfPopulation_Affected desc

--showing countries with the highest deathcount per population 
-- CASTING a calculated data type into an integer when it shows the count number as a year.

select location, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is null
group by location
order by TotalDeathCount desc

--to break things by continent 
--showing the continents with the highest death counts 
select continent, max(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBERS [grouping these by creating aggregrate funcitons] 

select SUM(new_cases) AS TOTAL_NewCases, SUM(cast(new_deaths as int)) as Total_NewDeaths, (Sum(cast(new_deaths as int))/SUM(new_cases))*100 as total_death_percentage 
from PortfolioProject..CovidDeaths
where continent is not null 
--group by date
order by 1,2



--JOINING TWO TABLES, DEATHS & VACCINATIONS 
select * 
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date

 --looking at the total percentage of the people that were vaccinated 
 select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
 where dea.continent is not null   
	order by 2,3 




