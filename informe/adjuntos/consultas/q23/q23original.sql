/* Q23 Oportunidad de ventas globales (Original) */
/* $1='13', $2='31', $3='23', $4='29', $5='30', $6='18', $7='17' */

prepare q23original as
select
  cntrycode,
  count(*) as numcust,
  sum(c_acctbal) as totacctbal
from (
  select
    substring(c_phone from 1 for 2) as cntrycode,
    c_acctbal
  from
    customer
  where
    substring(c_phone from 1 for 2) in
      ($1, $2, $3, $4, $5, $6, $7)
    and c_acctbal > (
      select
        avg(c_acctbal)
      from
        customer
      where
        c_acctbal > 0.00
        and substring(c_phone from 1 for 2) in
          ($1, $2, $3, $4, $5, $6, $7)
    )
    and not exists (
      select
        *
      from
        orders
      where
        o_custkey = c_custkey
    )
  ) as custsale
group by
  cntrycode
order by
  cntrycode;
