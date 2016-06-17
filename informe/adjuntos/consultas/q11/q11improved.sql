/* Q11 Proveedor con el minimo costo (Mejorado) */
/* $1 = 15, $2 = '%BRASS', $3 = 'EUROPE' */

prepare q11improved as
with minPerPart as (
  select
    min(ps_supplycost) as mpp_mincost,
    ps_partkey         as mpp_partkey
  from
    part,
    partsupp,
    supplier,
    nation,
    region
  where p_partkey          = ps_partkey
    and ps_suppkey         = s_suppkey
    and s_nationkey        = n_nationkey
    and n_regionkey        = r_regionkey
    and p_size             = $1
    and reverse(p_type) like reverse($2)
    and r_name             = $3
  group by
    mpp_partkey
  order by
    mpp_partkey
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
  minPerPart
where p_partkey          = ps_partkey
  and ps_suppkey         = s_suppkey
  and s_nationkey        = n_nationkey
  and p_size             = $1
  and reverse(p_type) like reverse($2)
  and r_name             = $3
  and ps_supplycost      = mpp_mincost
  and p_partkey          = mpp_partkey
order by
  s_acctbal desc,
  n_name,
  s_name,
  p_partkey;
