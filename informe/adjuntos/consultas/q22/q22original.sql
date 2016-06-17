/* Q22 Proveedor con el minimo costo (Original) */
/* $1= 'Brand#45', $2='MEDIUM POLISHED%', $3=49, $4=14, $5=23, $6=45, $7=19, $8=3, $9=36, $10=9 */

/* Q22 Relacion parte/proveedor (Original) */

prepare q22original AS
select
  p_brand,
  p_type,
  p_size,
  count(distinct ps_suppkey) as supplier_cnt
from
  partsupp,
  part
where
  p_partkey = ps_partkey
  and p_brand <> $1
  and p_type not like $2
  and p_size in ($3, $4, $5, $6, $7, $8, $9, $10)
  and ps_suppkey not in (
    select
      s_suppkey
    from
      supplier
    where
      s_comment like '%Customer%Complaints%'
  )
group by
  p_brand,
  p_type,
  p_size
order by
  supplier_cnt desc,
  p_brand,
  p_type,
  p_size;

/*
select
  p_brand,
  p_type,
  p_size,
  count(distinct ps_suppkey) as supplier_cnt
from
  partsupp,
  part
where
  p_partkey = ps_partkey
  and p_brand <> $1
  and p_type not like $2
  and p_size in ($3, $4, $5, $6, $7, $8, $9, $10)
  and ps_suppkey not in (
    select
      s_suppkey
    from
      supplier
    where
      s_comment like '%Customer%Complaints%'
  )
group by
  p_brand,
  p_type,
  p_size
order by
  supplier_cnt desc,
  p_brand,
  p_type,
  p_size;
*/
