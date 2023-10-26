--#1 Write a query to get the sum of impressions by day.
SELECT md.date, 
SUM (md.impressions) 
FROM marketing_data md 
GROUP BY md.date;

--#2 Write a query to get the top three revenue-generating states in order of best to worst.

select
	state,
	sum (revenue)
as staterevenue
from
	website_revenue wr
group by
	state
order by
	staterevenue desc
limit 3

--How much revenue did the third best state generate? 
--$37,577

select
	state,
	staterevenue
from
	(
	select
		state,
		sum (revenue)
as staterevenue
	from
		website_revenue wr
	group by
		state
	order by
		staterevenue desc
	limit 3 )
order by
	staterevenue
asc
limit 1

--#3 Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.
select
	ci.name,
	sum(md.cost),
	sum(md.impressions),
	sum(md.clicks),
	sum(wr.revenue)
from
	campaign_info ci
join marketing_data md on
	md.campaign_id = ci.id
join website_revenue wr on
	wr.campaign_id = ci.id
group by ci.name 

--#4 Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?
--GA

select
	sum(md.conversions),
	md.geo,
	ci.name
from
	campaign_info ci
join marketing_data md on
	md.campaign_id = ci.id
where
	ci.name = 'Campaign5'
group by
	md.geo
ORDER by
	md.geo asc
limit 1

--#5 In your opinion, which campaign was the most efficient, and why?
--While Campaign 3 had the most profit, Campaign 4 was the most efficient in my opinion. This is because it had the most impressions per dollar spent on the campaign, and the most favorable cost to revenue ratio of all five campaigns.

--Bonus
-- Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
--Based on conversions, Friday is the best day of the week to run ads. This bonus was a tough one! Becasue of some formatting issues I was stuggling with both the "servdate" and "dayname," so I ended up writing a simple query and using the text funtion on excel to convert the dates. 

SELECT
	md.date,
	SUM (md.conversions)
FROM
	marketing_data md
GROUP BY
	md.date	
order by
	sum(md.conversions) desc;