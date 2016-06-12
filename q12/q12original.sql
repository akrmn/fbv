/* Q12 Prioridad de Envío (Original) */
/* ​$1='BUILDING', $2='1995-­03­-15' */

/*select 
  l_orderkey,
  sum(l_extendedprice*(1-l_discount)) as revenue,  
  o_orderdate,
  o_shippriority 
from 
  customer,
  orders,
  lineitem 
where
  c_mktsegment = $1 
  and c_custkey = o_custkey
  and l_orderkey = o_orderkey 
  and o_orderdate < $2
  and l_shipdate > $2 
group by
  l_orderkey,
  o_orderdate, 
  o_shippriority 
order by
  revenue desc,
  o_orderdate;*/

prepare q12original as
select 
  l_orderkey,
  sum(l_extendedprice*(1-l_discount)) as revenue,  
  o_orderdate,
  o_shippriority 
from 
  customer,
  orders,
  lineitem 
where
  c_mktsegment = $1 
  and c_custkey = o_custkey
  and l_orderkey = o_orderkey 
  and o_orderdate < $2
  and l_shipdate > $2 
group by
  l_orderkey,
  o_orderdate, 
  o_shippriority 
order by
  revenue desc,
  o_orderdate;

/*
select 
  l_orderkey,
  sum(l_extendedprice*(1-l_discount)) as revenue,  
  o_orderdate,
  o_shippriority 
from 
  customer,
  orders,
  lineitem 
where
  c_mktsegment = $1 
  and c_custkey = o_custkey
  and l_orderkey = o_orderkey 
  and o_orderdate < $2
  and l_shipdate > $2 
group by
  l_orderkey,
  o_orderdate, 
  o_shippriority 
order by
  revenue desc,
  o_orderdate;
*/
