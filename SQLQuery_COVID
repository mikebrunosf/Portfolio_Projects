Select *
From [Portfolio Project]..CovidDeaths$
Where continent is not NULL
Order by 3, 4

--Select *
--From [Portfolio Project]..CovidVaccinations
--Order by 3, 4

Select Location, date, total_cases, new_cases, total_deaths, population
From [Portfolio Project]..CovidDeaths$
Where continent is not NULL
Order by 1, 2

-- Looking at total cases vs total deaths

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases) *100 as Death_Percentage
From [Portfolio Project]..CovidDeaths$
Where location like '%states%'
Where continent is not NULL
Order by 1, 2

--Looking at total cases vs population
Select Location, date, population, total_cases, (total_cases/population) *100 as Percentage_Infected_Population
From [Portfolio Project]..CovidDeaths$
Where location like '%states%'
Where continent is not NULL
Order by 1, 2

--Looking at Countries with Highest Infection Rate compared to Population

Select Location, population, MAX(total_cases) as Highest_Infection_Count, MAX((total_cases/population))*100 as Percentage_Infected_Population
From [Portfolio Project]..CovidDeaths$
--Where location like '%states%'
Where continent is not NULL
Group by Location, population
Order by Percentage_Infected_Population desc

--Looking at Countries with Highest Death Count per Population

Select Location, MAX(cast(total_deaths as int)) as Total_Death_Count
From [Portfolio Project]..CovidDeaths$
--Where location like '%states%'
Where continent is not NULL
Group by Location, population
Order by Total_Death_Count desc

--Showing continents with the highest death count per population

Select location, MAX(cast(total_deaths as int)) as Total_Death_Count
From [Portfolio Project]..CovidDeaths$
--Where location like '%states%'
Where continent is NULL
Group by location
Order by Total_Death_Count desc

--Global Numbers

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100  as Death_Percentage
From [Portfolio Project]..CovidDeaths$
--Where location like '%states%'
Where continent is not NULL
Group by date
Order by 1, 2

--Global Death Percentage

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100  as Death_Percentage
From [Portfolio Project]..CovidDeaths$
--Where location like '%states%'
Where continent is not NULL
--Group by date
Order by 1, 2

-- Looking at Total Vaccinations vs Total Population

Select dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations,
SUM(CAST(vax.new_vaccinations as int)) OVER (Partition by dea.location)
From [Portfolio Project]..CovidVaccinations$ vax
Join [Portfolio Project]..CovidDeaths$ dea
On dea.location = vax.location
and dea.date = vax.date
Where dea.continent is not null
Order by  2, 3

--

Select dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations,
SUM(CONVERT(int, vax.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) 
as Rolling_People_Vaccinated--, (Rolling_People_Vaccinated/ population)*100
From [Portfolio Project]..CovidVaccinations$ vax
Join [Portfolio Project]..CovidDeaths$ dea
On dea.location = vax.location
and dea.date = vax.date
Where dea.continent is not null
Order by  2, 3

--USE CTE

With PopvsVax (continent, location, date, population, new_vaccinations, Rolling_People_Vaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations,
SUM(CONVERT(int, vax.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) 
as Rolling_People_Vaccinated--, (Rolling_People_Vaccinated/ population)*100
From [Portfolio Project]..CovidVaccinations$ vax
Join [Portfolio Project]..CovidDeaths$ dea
On dea.location = vax.location
and dea.date = vax.date
Where dea.continent is not null
--Order by  2, 3
)
Select *, (Rolling_People_Vaccinated/Population) *100
From PopvsVax

--TEMP TABLE

Drop table if exists #Percent_Population_Vaccinated
Create table #Percent_Population_Vaccinated
(
continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
Rolling_People_Vaccinated numeric
)


Insert into #Percent_Population_Vaccinated
Select dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations,
SUM(CONVERT(int, vax.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) 
as Rolling_People_Vaccinated--, (Rolling_People_Vaccinated/ population)*100
From [Portfolio Project]..CovidVaccinations$ vax
Join [Portfolio Project]..CovidDeaths$ dea
On dea.location = vax.location
and dea.date = vax.date
--Where dea.continent is not null
--Order by  2, 3

Select *, (Rolling_People_Vaccinated/Population) *100
From #Percent_Population_Vaccinated

-- Creating a view to store data for later visualizations

Create View Percent_Population_Vaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vax.new_vaccinations,
SUM(CONVERT(int, vax.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date) 
as Rolling_People_Vaccinated--, (Rolling_People_Vaccinated/ population)*100
From [Portfolio Project]..CovidVaccinations$ vax
Join [Portfolio Project]..CovidDeaths$ dea
On dea.location = vax.location
and dea.date = vax.date
Where dea.continent is not null
--Order by  2, 3

Select *
From Percent_Population_Vaccinated
