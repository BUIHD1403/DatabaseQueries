--Q1
select DISTINCT c1.country, coalesce(c2.counting,0)
from customers c1
left join (select c.country, count(c.country) as counting
			from customers as c, orders as o
			where custid=ocust 
				and extract(year from o.odate)='2016'
			group by country) c2
on c1.country=c2.country;
