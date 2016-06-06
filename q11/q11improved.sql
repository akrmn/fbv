/* Q11 Proveedor con el minimo costo (Original) */
/* $1 = 15, $2 = '%BRASS', $3 = 'EUROPE' */

prepare q11Improved as
with minPerType as (
  select
    p_type             as mpt_type,
    min(ps_supplycost) as mpt_minCost
  from
    part,
    partsupp,
    supplier,
    nation,
    region
  where p_partkey          = ps_partkey
    and s_suppkey          = ps_suppkey
    and s_nationkey        = n_nationkey
    and n_regionkey        = r_regionkey
    and p_size             = $1
    and reverse(p_type) like reverse($2)
    and r_name             = $3
  group by
    p_type
)
select
  s_acctbal,
  s_name,
  n_name,
  p_partkey,
  p_mfgr,
  s_address,
  s_phone,
  s_comment
from
  part,
  supplier,
  partsupp,
  nation,
  region,
  minPerType
where p_partkey          = ps_partkey
  and s_suppkey          = ps_suppkey
  and s_nationkey        = n_nationkey
  and n_regionkey        = r_regionkey
  and p_size             = $1
  and reverse(p_type) like reverse($2)
  and r_name             = $3
  and p_type             = mpt_type
  and ps_supplycost      = mpt_minCost
order by
  s_acctbal desc,
  n_name,
  s_name,
  p_partkey;

/*
with minPerType as (
  select
    p_type             as mpt_type,
    min(ps_supplycost) as mpt_minCost
  from
    part,
    partsupp,
    supplier,
    nation,
    region
  where p_partkey          = ps_partkey
    and s_suppkey          = ps_suppkey
    and s_nationkey        = n_nationkey
    and n_regionkey        = r_regionkey
    and p_size             = 15
    and reverse(p_type) like reverse('%BRASS')
    and r_name             = 'EUROPE'
  group by
    p_type
)
select
  s_acctbal,
  s_name,
  n_name,
  p_partkey,
  p_mfgr,
  s_address,
  s_phone,
  s_comment
from
  part,
  supplier,
  partsupp,
  nation,
  region,
  minPerType
where p_partkey          = ps_partkey
  and s_suppkey          = ps_suppkey
  and s_nationkey        = n_nationkey
  and n_regionkey        = r_regionkey
  and p_size             = 15
  and reverse(p_type) like reverse('%BRASS')
  and r_name             = 'EUROPE'
  and p_type             = mpt_type
  and ps_supplycost      = mpt_minCost
order by
  s_acctbal desc,
  n_name,
  s_name,
  p_partkey;
*/
