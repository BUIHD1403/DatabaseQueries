-----Q5--
--Finished

select A.custid, A.numOrders,cast( (B.payment/A.numOrders) as numeric(12,2)) as averagePay																									
--Tim Luong Orders duoc dat per Customer: Lay luong customers tu custid of Customers table
from  (	select distinct c.custid custid, coalesce(b.numOrders,0) numOrders 
	from customers c
	left join 
		(select o.ocust as ocust, count(o.ordid) as numOrders
			from orders o
			group by o.ocust
			order by o.ocust
		) b
	on c.custid=b.ocust
	order by c.custid
   ) A
left join
 	--Tim tong so tien da spend per Customer
   ( select o.ocust as ocust,coalesce( sum(p.price*d.qty),0) payment
				from orders o
				left join details d
				on o.ordid=d.ordid
				left join products p
				on d.pcode=p.pcode
				group by o.ocust
				order by o.ocust
	) B			
on A.custid=B.ocust;