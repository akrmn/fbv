-- Índices para la consulta q21

--Elementos para orders
create index if not exists q21_orders_idx ON orders(o_orderkey, o_orderpriority);

--Elementos para lineitem
create index if not exists q21_lineitem_idx ON lineitem(l_receiptdate, l_commitdate, l_shipdate, l_shipmode, l_orderkey);