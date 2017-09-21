/*Generate a report containing three columns: Name, Grade and Mark. 
Ketty doesn't want the NAMES of those students who received a grade lower than 8. 
The report must be in descending order by grade -- i.e. higher grades are entered first. 
If there is more than one student with the same grade (8-10) assigned to them, 
order those particular students by their name alphabetically. 
Finally, if the grade is lower than 8, use "NULL" as their name and list them by their 
grades in descending order. If there is more than one student with the same grade (1-7) 
assigned to them, order those particular students by their marks in ascending order.*/

select 
    case 
        when grade < 8 then 'NULL' 
        else s.name 
    end,
    g.grade, s.marks 
from students as s, grades as g 
where s.marks between g.min_mark and g.max_mark 
order by grade desc, s.name;

/*Write a query to print the respective hacker_id and name of hackers who achieved full scores 
for more than one challenge. Order your output in descending order by the total number 
of challenges in which the hacker earned a full score. If more than one hacker received 
full scores in same number of challenges, then sort them by ascending hacker_id.*/

select h.hacker_id, h.name
    from submissions s
    join challenges c
        on s.challenge_id = c.challenge_id
    join difficulty d
        on c.difficulty_level = d.difficulty_level
    join hackers h
        on s.hacker_id = h.hacker_id 
    where s.score = d.score
group by h.hacker_id, h.name
    having count(s.hacker_id) > 1
order by count(s.hacker_id) desc, s.hacker_id asc;

/*Hermione decides the best way to choose is by determining the minimum number of 
gold galleons needed to buy each non-evil wand of high power and age. 
Write a query to print the id, age, coins_needed, and power of the wands that Ron's 
interested in, sorted in order of descending power. If more than one wand has same power, 
sort the result in order of descending age.*/

select w.id, wp.age, w.coins_needed, w.power from wands w
    join wands_property wp
        on w.code = wp.code
    where is_evil = 0 
        and w.coins_needed = (
            select min(coins_needed) from wands w1 
                join wands_property as wp1 
                    on w1.code = wp1.code
                where w1.power = w.power and wp1.age = wp.age)
order by 4 desc, 2 desc;

/*Write a query to print the hacker_id, name, and the total number of challenges created 
by each student. Sort your results by the total number of challenges in descending order. 
If more than one student created the same number of challenges, 
then sort the result by hacker_id. If more than one student created the same number of 
challenges and the count is less than the maximum number of challenges created, 
then exclude those students from the result.*/

select h.hacker_id, h.name, count(h.hacker_id) as tot from hackers h
    join challenges c
        on h.hacker_id = c.hacker_id
group by 1,2
    having tot in 
        (select t.cnt 
         /*query # of challenges created by each hacker, grouped up by hacker ID*/
            from (select count(*) as cnt from challenges
               group by hacker_id) t
         /*group up # of challenges each hacker created into X of hackers that created # of challenges */
         group by t.cnt
         /* has only one element */
         having count(t.cnt) = 1)
       
    or tot = 
        (select max(h3.num) as maximum
            from 
                (select h2.hacker_id, h2.name, count(h2.hacker_id) as num from hackers h2
                    join challenges c2
                        on h2.hacker_id = c2.hacker_id
                group by 1,2) h3) 
order by 3 desc, 1 asc;
   
/*Write a query to print the hacker_id, name, and total score of the hackers ordered 
by the descending score. If more than one hacker achieved the same total score, 
then sort the result by ascending hacker_id. Exclude all hackers with a total score of 0 
from your result.*/

select h.hacker_id, h.name, sum(ms.scr) as tot from
/*Query table of max score per challenge completed by each hacker ID*/
    (select hacker_id, max(score) scr from submissions s
    group by 1, s.challenge_id) ms
    join hackers h
        on ms.hacker_id = h.hacker_id
group by 1,2
    having tot > 0
order by sum(ms.scr) desc, h.hacker_id asc;