select c1.custid
from customers c1
where c1.custid not in
	(	select o.ocust
		from orders o
	    left join details d
	    on d.ordid=o.ordid
	    left join products p
	    on d.pcode=p.pcode
	    group by o.ocust, extract(year from o.odate),p.ptype
		having extract(year from o.odate) = 2016
	    and p.ptype='BOOK'
		order by o.ocust
	) 
order by c1.custid;
