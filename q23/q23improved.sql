/* Q23 Oportunidad de ventas globales (Mejorado) */
/* $1='13', $2='31', $3='23', $4='29', $5='30', $6='18', $7='17' */

prepare q23improved as
select
  substring(c_phone from 1 for 2) as cntrycode,
  count(1)                        as numcust,
  sum(c_acctbal)                  as totacctbal
from
  customer
where substring(c_phone from 1 for 2) in ($1, $2, $3, $4, $5, $6, $7)
  and c_acctbal > (
    select
      avg(c_acctbal)
    from
      customer
    where substring(c_phone from 1 for 2) in ($1, $2, $3, $4, $5, $6, $7)
      and c_acctbal > 0.00
  )
  and not exists (
    select 1
    from
      orders
    where
      o_custkey = c_custkey
  )
group by
  cntrycode
order by
  cntrycode;

/*
select
  substring(c_phone from 1 for 2) as cntrycode,
  count(1)                        as numcust,
  sum(c_acctbal)                  as totacctbal
from
  customer
where substring(c_phone from 1 for 2) in ('13', '31', '23', '29', '30', '18', '17')
  and c_acctbal > (
    select
      avg(c_acctbal)
    from
      customer
    where substring(c_phone from 1 for 2) in ('13', '31', '23', '29', '30', '18', '17')
      and c_acctbal > 0.00
  )
  and not exists (
    select 1
    from
      orders
    where
      o_custkey = c_custkey
  )
group by
  cntrycode
order by
  cntrycode;
*/
