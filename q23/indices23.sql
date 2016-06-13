--índices para las consulta 23

create index if not exists idx_q23_c_ctrycode_acctbal
  on customer (substring(c_phone from 1 for 2), c_acctbal);

create index if not exists idx_q23_o_custkey
  on orders (o_custkey);
