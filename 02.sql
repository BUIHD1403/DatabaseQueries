--Q2
select C.ptype as ptype, cast ( (cast(C.qty as numeric(12,2))/ B.numOrders) as numeric(12,2) )
from	(select sum(d.qty) qty, p.ptype ptype 
			from details d
			join products p
			on d.pcode=p.pcode
			group by ptype
	)C
join
  (	select count(A.ordid) as numOrders, ptype
	from	(select distinct ordid,ptype 
				from details d
				left join products p
				on d.pcode=p.pcode
		) A
	group by ptype
  )B
on C.ptype=B.ptype;
