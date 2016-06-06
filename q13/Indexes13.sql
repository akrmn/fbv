--Índices para las consulta 13

--Elementos para la fecha
CREATE INDEX q13_orders_idx on orders(o_orderdate, o_orderkey, o_custkey); 

--Elementos para lineitem
CREATE INDEX q13_lineitem_idx on lineitem(l_returnflag, l_orderkey, l_extendedprice, l_discount);

