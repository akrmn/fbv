-- Q23: Oportunidad de ventas globales -----------------------------------------
PREPARE q23 AS
SELECT cntrycode, count(*) AS numcust, sum(c_acctbal) AS totacctbal
FROM (
    SELECT substring(c_phone FROM 1 for 2) AS cntrycode, c_acctbal
    FROM customer
    WHERE substring(c_phone FROM 1 for 2) IN ($1, $2, $3, $4, $5, $6, $7)
        AND c_acctbal > (
            SELECT avg(c_acctbal)
            FROM customer
            WHERE c_acctbal > 0.00
                AND substring(c_phone FROM 1 for 2)
                    IN ($1, $2, $3, $4, $5, $6, $7))
        AND not exists (SELECT * FROM orders WHERE o_custkey = c_custkey))
AS custsale
GROUP BY cntrycode
ORDER BY cntrycode;