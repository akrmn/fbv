--índices para la consulta 12

--elementos para orders
create index q12_orders_idx on orders(o_custkey, o_orderdate, o_orderkey, o_shippriority);

--elementos para lineitem
create index q12_lineitem_idx on lineitem(l_shipdate, l_orderkey, l_extendedprice, l_discount);

--elementos para customer
create index q12_customer_idx on customer(c_mktsegment, c_custkey);
