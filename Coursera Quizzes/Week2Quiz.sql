Analytics using MySQL - Week 2 Quiz

5. /*In how many columns of the STRINFO table of the Dillard’s database are NULL values *permitted*?*/
    database ua_dillards
    help table strinfo;

6. /*In how many columns of the STRINFO table of the Dillard’s database are NULL values *present*?*/
    select city, state, zip from strinfo
    where city is null or state is null or zip is null;

7. /*What was the highest original price in the Dillard’s database of the item with SKU 3631365?*/
    select orgprice from trnsact
    where sku = 3631365
    order by 1 desc;

8. /*What is the color of the Liz Claiborne brand item with the highest SKU # in the Dillard’s database (the Liz Claiborne brand is abbreviated “LIZ CLAI” in the Dillard’s database)?*/
    select top 1
    color 
    from skuinfo
    where brand = 'LIZ CLAI'
    order by sku desc;

10. /*What is the sku number of the item in the Dillard’s database that had the highest original sales price?*/
    select top 1
    sku
    from TRNSACT
    order by orgprice desc;

11. /*According to the strinfo table, in how many states within the United States are Dillard’s stores located?*/
    select count(distinct state) from strinfo;

12. /*How many Dillard’s departments start with the letter “e”*/
    select count(distinct deptdesc) from deptinfo
    where deptdesc like 'e%';

13. /*What was the date of the earliest sale in the database where the sale price of the item did not equal the original price of the item, and what was the largest margin (original price minus sale price) of an item sold on that earliest date?*/
    select top 10
    saledate, (orgprice - sprice)
        from trnsact
    where orgprice - sprice ^= 0
    order by 1, 2 desc;

15. /*Which of the following brand names with the word/letters “liz” in them exist in the Dillard’s database? Select all that apply. Note that you will need more than a single correct selection to answer the question correctly.*/
    select distinct brand 
        from skuinfo
    where brand like '%liz%';

16. /*What is the lowest store number of all the stores in the STORE_MSA table that are in the city of “little rock”,”memphis”, or “tulsa”?*/
    select top 10 
    store 
        from store_msa
    where city = 'little rock' 
        or city = 'memphis' 
        or city = 'tulsa'
    order by store asc;