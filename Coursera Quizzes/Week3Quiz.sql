Analytics using MySQL - Week 3 Quiz

3. /*On what day was Dillard’s income based on total sum of purchases the greatest*/

    select top 10
    saledate, sum(amt) income from trnsact t
    group by saledate
    order by income desc;

4. /*What is the deptdesc of the departments that have the top 3 greatest numbers of skus from the skuinfo table associated with them?*/

select top 3
    d.deptdesc
from skuinfo s
    inner join deptinfo as d
        on s.dept = d.dept
group by d.deptdesc
order by count(s.sku) desc;

5. /*What is the average amount of profit Dillard’s made per day?*/

select avg(sq.profit)
from 
(select t.saledate, sum(t.amt) as profit from trnsact t
 group by t.saledate, t.stype
    having t.stype = 'P') sq;

7. /*What is the average amount of profit Dillard’s made per day?*/



8. /*The store_msa table provides population statistics about the geographic location around a store. Using one query to retrieve your answer, how many MSAs are there within the state of North Carolina (abbreviated “NC”), and within these MSAs, what is the lowest population level (msa_pop) and highest income level (msa_income)?*/

select count(msa), min(msa_pop), max(msa_income) 
from store_msa
where state = 'NC';

9./*What department (with department description), brand, style, and color brought in the greatest total amount of sales?*/

select top 3
d.dept, d.deptdesc, s.brand, s.style, s.color, s.sku, sq.income
from skuinfo s
    inner join 
        (select top 10
         t.sku, sum(t.amt) income from trnsact t
         where stype = 'P'
         group by t.sku
         order by income desc) sq
             on s.sku = sq.sku
    inner join deptinfo d
        on s.dept = d.dept
order by sq.income desc;

10. /*How many stores have more than 180,000 distinct skus associated with them in the skstinfo table?*/
with
    sq as (select s.store from strinfo s
           inner join skstinfo sk
              on s.store = sk.store
           group by s.store
           having count(distinct sk.sku) > 180000)

select count(sq.store) from sq;

11. /*Look at the data from all the distinct skus in the “cop” department with a “federal” brand and a “rinse wash” color.
      You'll see that these skus have the same values in some of the columns, meaning that they have some features in common.
      In which columns do these skus have different values from one another, meaning that their features differ in the categories represented by the columns? 
      Choose all that apply. Note that you will need more than a single correct selection to answer the question correctly.*/ 

select *
from skuinfo s
     left join deptinfo d
         on s.dept = d.dept
where d.deptdesc = 'cop'
and s.brand = 'federal'
and s.color = 'rinse wash';

12. /*How many skus are in the skuinfo table, but NOT in the skstinfo table?*/

with 
c1 as (select count(distinct s.sku) skucnt
       from skuinfo s),
c2 as (select count(distinct sk.sku) skscnt
       from skstinfo sk)

select c1.skucnt - c2.skscnt from c1
    cross join c2;

13. /*In what city and state is the store that had the greatest total sum of sales?*/

with
c1 as (select top 10
       t.store, sum(t.amt) sales from trnsact t
           where stype = 'P'
       group by t.store
       order by sales desc)

select top 3
s.store, s.city, s.state, c1.sales from strinfo s
    inner join c1
       on s.store = c1.store
order by c1.sales desc;

14. /*How many states have more than 10 Dillards stores in them?*/

with 
c1 as (select count(distinct store) tally, state from 
       strinfo
       group by state
           having tally > 10)

select count(c1.tally) from c1;

15. /*What is the suggested retail price of all the skus in the “reebok” department with the “skechers” brand and a “wht/saphire” color?*/

select s.sku, t.sprice from trnsact t
    inner join skuinfo s
        on s.sku = t.sku
    inner join deptinfo d
        on s.dept = d.dept
where d.deptdesc = 'reebok'
and s.brand = 'skechers'
and s.color = 'wht/saphire';