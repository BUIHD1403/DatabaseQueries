--------------------Q3------ Finished
select i.invid 
from (
	select d.ordid, cast( (sum(d.qty*price)*1.2) as numeric(8,2) ) as totalCost
	from details d, products p
	where d.pcode=p.pcode
	group by ordid
	order by d.ordid
	) A
join invoices i
on A.totalCost=i.amount
and A.ordid=i.ordid;
