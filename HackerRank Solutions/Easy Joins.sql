/*Given the CITY and COUNTRY tables, 
query the sum of the populations of all cities where the CONTINENT is 'Asia'.*/

Select sum(city.population) from CITY
    join COUNTRY ON 
    CITY.countrycode = COUNTRY.code
    where CONTINENT = 'Asia';

/*Given the CITY and COUNTRY tables, query the names of all cities where the 
CONTINENT is 'Africa'.*/

select city.name from city
    join country ON 
    city.countrycode = country.code
where continent = "Africa";

/*Given the CITY and COUNTRY tables, query the names of all the continents 
(COUNTRY.Continent) and their respective average city populations (CITY.Population) 
rounded down to the nearest integer.*/

select country.continent, floor(avg(city.population)) from city
    join country on 
    city.countrycode = country.code
group by 1
order by 1;

