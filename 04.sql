--Q4 Done
select A.ptype, A.ocust
from (select o.ocust as ocust, sum(d.qty) as sqty, p.ptype as ptype
				from orders o
				join details d
				on o.ordid=d.ordid
				join products p
				on d.pcode=p.pcode
				group by o.ocust, p.ptype
				order by o.ocust ) A 
inner join 
	(	select MAX(sqty) as Maxsqty,B.ptype as ptype
		from (select o.ocust as ocust, sum(d.qty) as sqty, p.ptype as ptype
			from orders o
			join details d
			on o.ordid=d.ordid
			join products p
			on d.pcode=p.pcode
			group by o.ocust, p.ptype
			order by o.ocust ) B
		group by B.ptype
	)C
on A.ptype=C.ptype
and A.sqty=C.Maxsqty;