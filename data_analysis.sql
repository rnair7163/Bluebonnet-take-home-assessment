/*
For this exercise, I will be writing queries in PostgreSQL
*/

/*
Question 1 - How many people not registered as Democrats voted in the Primaries? 
*/
select count(voter_id) as voter_count -- I am not distict count here since it's already mentioned that there are no duplicates
from 2021_Special_Primaries
where current_party <> 'D';

/*
Question 2 - What percentage of Primary voters were born since 1990 (including 1990)?
*/
select round((count(case when year_of_birth >= '1990' then voter_id end)::decimal 
       /
       count(voter_id)) * 100, 2) as voter_percentage -- rounding it up to 2 decimals
from 2021_Special_Primaries;

/*
Question 3 - How many voters voted in a Primary AND a General Election in 2021?
*/
select count(sp.voter_id) as voter_count 
from 2021_Special_Primaries as sp 
join 2021_Special_Generals as sg 
  on sp.voter_id = sg.voter_id;

/*
Question 4 - How many voters voted in a Primary but not a General in 2021?
*/

select voter_id 
from 2021_Special_Primaries
where voter_id not in (select voter_id from 2021_Special_Generals);

/*
Question 5 - Produce counts for how many votes were cast in each Zip Code across both the Generals and Primaries 
             (i.e., if one person voted in both a General and a Primary, that counts as two votes cast within their Zip Code)
*/

