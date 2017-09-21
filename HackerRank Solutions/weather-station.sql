1. /*Query a list of CITY and STATE from the STATION table.*/

select city, state from station;

3. /*Query a list of CITY names from STATION with even ID numbers only. You may print the results in any order, but must exclude duplicates from your answer.*/

select city from station
where ID % 2 = 0
group by city;

4. /*Let N be the number of CITY entries in STATION, and let N' be the number of distinct CITY names in STATION; query the value of N-N' from STATION. In other words, find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.*/

select (count(city) - count(distinct city)) from station;

5. /*Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.*/

select ls.city, max(ls.len) name 
    from (select city, length(city) len from station
            group by city) ls
group by ls.city
order by name desc
limit 1;

select ls.city, min(ls.len) name 
    from (select city, length(city) len from station
            group by city) ls
group by ls.city
order by name asc
limit 1;

6. /*Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.*/

select city from station
where city rlike '^[a|e|i|o|u]';

7. /*Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.*/

select city from station
where city rlike '[a|e|i|o|u]$'
group by city;

8. /*Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.*/
select distinct city from station
where city rlike '^[a|e|i|o|u].*[a|e|i|o|u]$';

9. /*Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.*/

select distinct city from station
where city not rlike '^[a|e|i|o|u]';

10. /*Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.*/

select distinct city from station
where city not rlike '[a|e|i|o|u]$';

11. /*Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.*/

select distinct city from station
where city not rlike '^[a|e|i|o|u].*[a|e|i|o|u]$';

12. /*Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.*/

select distinct city from station 
where city regexp '^[^aeiou].*[^aeiou]$';
