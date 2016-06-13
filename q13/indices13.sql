--índices para las consulta 13

--elementos para la fecha
create index if not exists q13_orders_idx on orders(o_orderdate, o_orderkey, o_custkey);

--elementos para lineitem
create index if not exists q13_lineitem_idx on lineitem(l_returnflag, l_orderkey, l_extendedprice, l_discount);

