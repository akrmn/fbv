create index idx_c_ctrycode_acctbal
  on customer (substring(c_phone from 1 for 2), c_acctbal);

create index idx_c_acctbal
  on customer (c_acctbal);

create index idx_c_acctbal_ctrycode
  on customer (c_acctbal, substring(c_phone from 1 for 2));
