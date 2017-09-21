/*
Consider P1(a,b) and P2(c,d) to be two points on a 2D plane.
 a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
 c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.
*/

select round((max(lat_n)-min(lat_n)) + (max(long_w)-min(long_w)),4) from station;

/*Consider P1(a,b) and P2(c,d) to be two points on a 2D plane where (a,b) are the 
respective minimum and maximum values of Northern Latitude (LAT_N) and (c,d) are the 
respective minimum and maximum values of Western Longitude (LONG_W) in STATION.

Query the Euclidean Distance between points P1 and P2 and format your answer to 
display 4 decimal digits.*/

select round(sqrt((power(max(lat_n)-min(lat_n),2)) + (power(max(long_w)-min(long_w),2))),4) 
from station;

/*A median is defined as a number separating the higher half of a data set from the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places.*/

select round(s.lat_n,4) med 
from station s where 
    (select count(lat_n) 
     from station 
     where lat_n < s.lat_n ) = 
    (select count(lat_n) 
     from station 
     where lat_n > s.lat_n)