/*
  Script de creación de esquema y carga de datos para el proyecto de ci5313
  Elaborado: Abril 2016.
  Autor: Jose Noel Mendoza
*/

--  Limpiando la bd...

drop table if exists Lineitem;
drop table if exists Orders;
drop table if exists Customer;
drop table if exists Partsupp;
drop table if exists Supplier;
drop table if exists Nation;
drop table if exists Region;
drop table if exists Part;

-- Creando tablas...
create table Part(
  p_partkey     serial  primary key,
  p_name        text    check (char_length(p_name) <= 55),
  p_mfgr        text    check (char_length(p_mfgr) <= 25),
  p_brand       text    check (char_length(p_brand) <= 10),
  p_type        text    check (char_length(p_type) <= 25),
  p_size        integer check (p_size >= 0),
  p_container   text    check (char_length(p_container) <= 10),
  p_retailprice decimal check (p_retailprice >= 0),
  p_comment     text    check (char_length(p_comment) <= 23)
);

create table Region(
  r_regionkey serial primary key,
  r_name      text   check (char_length(r_name) <= 25),
  r_comment   text   check (char_length(r_comment) <= 152)
);

create table Nation(
  n_nationkey serial  primary key,
  n_name      text    check (char_length(n_name) <= 25),
  n_regionkey integer not null,
  n_comment   text    check (char_length(n_comment) <= 152)
);

create table Supplier(
  s_suppkey   serial primary key,
  s_name      text   check (char_length(s_name) <= 25),
  s_address   text   check (char_length(s_address) <= 40),
  s_nationkey integer not null references Nation(n_nationkey),
  s_phone     text   check (char_length(s_phone) <= 15),
  s_acctbal   decimal,
  s_comment   text   check (char_length(s_comment) <= 101)
);


create table Partsupp(
  ps_partkey    integer not null references Part(p_partkey),
  ps_suppkey    integer not null references Supplier(s_suppkey),
  ps_availqty   integer check (ps_availqty >= 0),
  ps_supplycost decimal check (ps_supplycost >= 0),
  ps_comment    text    check (char_length(ps_comment) <= 199),
  primary key (ps_partkey, ps_suppkey)
);

create table Customer(
  c_custkey    serial  primary key,
  c_name       text    check (char_length(c_name) <= 25),
  c_address    text    check (char_length(c_address) <= 40),
  c_nationkey  integer not null references Nation(n_nationkey),
  c_phone      text    check (char_length(c_phone) <= 15),
  c_acctbal    decimal,
  c_mktsegment text    check (char_length(c_mktsegment) <= 10),
  c_comment    text    check (char_length(c_comment) <= 117)
);

create table Orders(
  o_orderkey      serial primary key,
  o_custkey       integer not null references Customer(c_custkey),
  o_orderstatus   text    check (char_length(o_orderstatus) = 1),
  o_totalprice    decimal check (o_totalprice >= 0),
  o_orderdate     date,
  o_orderpriority text    check (char_length(o_orderpriority) <= 15),
  o_clerk         text    check (char_length(o_clerk) <= 15),
  o_shippriority  integer,
  o_comment       text    check (char_length(o_comment) <= 79)
);

create table Lineitem(
  l_orderkey      integer  not null references Orders(o_orderkey),
  l_partkey       integer  not null references Part(p_partkey),
  l_suppkey       integer  not null references Supplier(s_suppkey),
  l_linenumber    integer,
  l_quantity      decimal  check (l_quantity >= 0),
  l_extendedprice decimal  check (l_extendedprice >= 0),
  l_discount      decimal  check (l_discount between 0.00 and 1.00),
  l_tax           decimal  check (l_tax >= 0),
  l_returnflag    text     check (char_length(l_returnflag) = 1),
  l_linestatus    text     check (char_length(l_linestatus) = 1),
  l_shipdate      date,
  l_commitdate    date,
  l_receiptdate   date,
  l_shipinstruct  text     check (char_length(l_shipinstruct) <= 25),
  l_shipmode      text     check (char_length(l_shipmode) <= 10),
  l_comment       text     check (char_length(l_comment) <= 44),
  foreign key (l_partkey,l_suppkey) references Partsupp(ps_partkey,ps_suppkey),
  primary key (l_orderkey,l_linenumber),
  check (l_shipdate <= l_receiptdate)
);

-- Cargando los datos usando \copy ... 
\copy Part from '/var/lib/postgresql/datos/csv/part.csv' delimiter '|' CSV;
\copy Region from '/var/lib/postgresql/datos/csv/region.csv' delimiter '|' CSV;
\copy Nation from '/var/lib/postgresql/datos/csv/nation.csv' delimiter '|' CSV;
\copy Supplier from '/var/lib/postgresql/datos/csv/supplier.csv' delimiter '|' CSV;
\copy Partsupp from '/var/lib/postgresql/datos/csv/partsupp.csv' delimiter '|' CSV;
\copy Customer from '/var/lib/postgresql/datos/csv/customer.csv' delimiter '|' CSV;
\copy Orders from '/var/lib/postgresql/datos/csv/orders.csv' delimiter '|' CSV;
\copy Lineitem from '/var/lib/postgresql/datos/csv/lineitem.csv' delimiter '|' CSV;

--índices para las consulta 11

create index idx_q11_p_size_reverse_type
  on part (p_size, reverse(p_type) text_pattern_ops);

create index idx_q11_partsupp
  on partsupp (ps_partkey, ps_suppkey, ps_supplycost);
  
--índices para la consulta 12
  
create index q12_orders_idx on orders(o_custkey, o_orderdate, o_orderkey, o_shippriority);

create index q12_lineitem_idx on lineitem(l_shipdate, l_orderkey, l_extendedprice, l_discount);

create index q12_customer_idx on customer(c_mktsegment, c_custkey);

--índices para las consulta 13

create index q13_orders_idx on orders(o_orderdate, o_orderkey, o_custkey);

create index q13_lineitem_idx on lineitem(l_returnflag, l_orderkey, l_extendedprice, l_discount);

-- Índices para la consulta q21

create index q21_orders_idx ON orders(o_orderkey, o_orderpriority);

create index q21_lineitem_idx ON lineitem(l_receiptdate, l_commitdate, l_shipdate, l_shipmode, l_orderkey);

--índices para las consulta 22

create index idx_q22_part on part (p_brand, p_type, p_size);

--índices para las consulta 23

create index idx_q23_c_ctrycode_acctbal
  on customer (substring(c_phone from 1 for 2), c_acctbal);

create index idx_q23_o_custkey
  on orders (o_custkey);






