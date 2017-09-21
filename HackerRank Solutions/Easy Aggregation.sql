/*Query a count of the number of cities in CITY having a Population larger than 100,000*/

select count(distinct name) from city
where population > 100000;

/*Query the total population of all cities in CITY where District is California.*/

select sum(population) from city
where district = 'California';

/*Query the average population of all cities in CITY where District is California.*/

select avg(population) from city
where district = 'california';

/*Query the average population for all cities in CITY, rounded down to the nearest integer.*/

select floor(avg(population)) from city;

/*Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.*/

select sum(population) from city
where countrycode = 'JPN';

/*Query the difference between the maximum and minimum populations in CITY.*/

select (max(population) - min(population)) from city;

/*Samantha was tasked with calculating the average monthly salaries for all employees 
  in the EMPLOYEES table, but did not realize her keyboard's  key was broken 
  until after completing the calculation. She wants your help finding the difference 
  between her miscalculation (using salaries with any zeroes removed), 
  and the actual average salary.

  Write a query calculating the amount of error (i.e.:  average monthly salaries), 
  and round it up to the next integer.*/

select ceiling(avg(salary) - avg(replace(salary, 0, ''))) from employees;

/*We define an employee's total earnings to be their monthly salary x months worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as  space-separated integers.*/

select (salary*months) tot, count(*) 
from employee 
group by tot 
order by tot desc 
limit 1;

/*Query the following two values from the STATION table:

The sum of all values in LAT_N rounded to a scale of 2 decimal places.
The sum of all values in LONG_W rounded to a scale of 2 decimal places.*/

select round(sum(LAT_N),2), round(sum(LONG_W),2) from station;

/*Query the sum of Northern Latitudes (LAT_N) from STATION having values greater 
than 38.7880 and less than 137.2345. Truncate your answer to 4 decimal places.*/

select truncate(sum(lat_n),4) from station
where lat_n between 38.7880 and 137.2345;

/*Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to 4 decimal places.*/

select truncate(max(lat_n),4) from station
where lat_n < 137.2345;

/*Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. Round your answer to  decimal places.*/

Select round(long_w,4) from station
where lat_n < 137.2345 
order by lat_n desc 
limit 1;

/*Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780 . Round your answer to 4 decimal places.*/

select round(min(lat_n), 4) from station
where lat_n > 38.7780;

/*Query the Western Longitude (LONG_W) for the smallest Northern Latitude (LAT_N) in STATION that is greater than 38.7780. Round your answer to  decimal places*/

select round(long_w,4) from station
where lat_n > 38.7780
order by lat_n asc
limit 1;
