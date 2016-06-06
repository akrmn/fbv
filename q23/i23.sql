create index idx_c_ctrycode_acctbal
  on customer (substring(c_phone from 1 for 2), c_acctbal);

create index idx_o_custkey
  on orders (o_custkey);
