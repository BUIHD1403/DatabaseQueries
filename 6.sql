select C.ptype, count(C.ordid) totalNumber 
from (
		select distinct p.ptype,B.ordid
		from	(
				select A.ordid ordid
				from	( select d.ordid ordid, p.ptype ptype 
						from details d
						join products p
						on d.pcode=p.pcode
						group by d.ordid, p.ptype
						order by d.ordid
						) A
				group by A.ordid
				having count(*) < 2
				)B
		join details d
		on B.ordid=d.ordid
		join products p
		on d.pcode=p.pcode
		group by p.ptype,B.ordid
)C
group by C.ptype;