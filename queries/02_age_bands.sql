-- Średnie koszty w pasmach wieku: 18–29, 30–39, 40–49, 50+ + ranking.

with age_statistics as (
select 
case	
	when age between 18 and 29 then '18-29'
    when age between 30 and 39 then '30-39'
    when age between 40 and 49 then '40-49'
    else '50+'
	end 					as age_groups,
	round(avg(charges),1) 	as average_charges,
    count(*)				as cnt
from insurance
group by age_groups
order by age_groups desc
)

select
	age_groups,
    average_charges,
    cnt,
    dense_rank() over ( order by average_charges desc ) as ranking
from age_statistics
order by ranking
