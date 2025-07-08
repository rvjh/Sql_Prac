select * from purchase_history;

-- customers purchased diff products on different dates


select userid 
-- count(productid) p1,count(distinct productid) p2, count(distinct purchasedate)
from purchase_history
group by userid
having count(productid) = count(distinct productid) and count(distinct purchasedate)=2









