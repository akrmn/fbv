-- Q11: Proveedor con el mínimo costo ------------------------------------------------------------
PREPARE q11 AS
SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address,
    s_phone, s_comment
FROM part, supplier, partsupp, nation, region
WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey AND p_size = $1
    AND p_type LIKE $2 AND s_nationkey = n_nationkey
    AND n_regionkey = r_regionkey
    AND r_name = $3 AND ps_supplycost = (
        SELECT min(ps_supplycost)
        FROM partsupp,supplier,nation, region
        WHERE p_partkey = ps_partkey AND s_suppkey = ps_suppkey
            AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey
            AND r_name = $3 )
ORDER BY s_acctbal DESC;

-- EXECUTE q11 (15, '%BRASS', 'EUROPE');


-- Q12: Prioridad de envío -----------------------------------------------------
PREPARE q12 AS
SELECT l_orderkey, sum(l_extendedprice*(1 - l_discount)) AS revenue,
    o_orderdate,o_shippriority
FROM customer, orders, lineitem
WHERE c_mktsegment = $1 AND c_custkey = o_custkey AND l_orderkey = o_orderkey
    AND o_orderdate < $2 AND l_shipdate > $2
GROUP BY l_orderkey, o_orderdate, o_shippriority
ORDER BY revenue DESC, o_orderdate;

-- EXECUTE q12('BUILDING', '1995-03-15');


-- Q13: Reporte de ítems devueltos ---------------------------------------------
PREPARE q13 AS
SELECT c_custkey,c_name, sum(l_extendedprice * (1 - l_discount)) AS revenue,
    c_acctbal, n_name, c_address, c_phone, c_comment
FROM customer, orders, lineitem, nation
WHERE c_custkey = o_custkey AND l_orderkey = o_orderkey
    AND o_orderdate >= $1 AND o_orderdate < $1 + interval '3 month'
    AND l_returnflag = 'R' AND c_nationkey = n_nationkey
GROUP BY c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment
ORDER BY revenue DESC;

-- EXECUTE q13('1993-10-01');


-- Q21: Modos de envío y orden de prioridad ------------------------------------
PREPARE q21 AS
SELECT l_shipmode,
    sum (CASE
        WHEN o_orderpriority = '1-URGENT'
        OR o_orderpriority = '2-HIGH'
            THEN 1
            ELSE 0
        END) AS high_line_count,
    sum(CASE
        WHEN o_orderpriority <> '1-URGENT'
        AND o_orderpriority <> '2-HIGH'
            THEN 1
            ELSE 0
        END) AS low_line_count
FROM orders,lineitem
WHERE o_orderkey = l_orderkey AND l_shipmode IN ($1, $2)
    AND l_commitdate < l_receiptdate AND l_shipdate < l_commitdate
    AND l_receiptdate >= $3 AND l_receiptdate < $3 + interval '1 year'
GROUP BY l_shipmode
ORDER BY l_shipmode;

-- EXECUTE q21('MAIL', 'SHIP', '1994-01-01');


-- Q22: Relación parte/proveedor -----------------------------------------------
PREPARE q22 AS
SELECT p_brAND, p_type, p_size, count(distinct ps_suppkey) AS supplier_cnt
FROM partsupp, part
WHERE p_partkey = ps_partkey AND p_brAND <> $1
    AND p_type not LIKE $2 AND p_size IN ($3, $4, $5, $6, $7, $8, $9, $10)
    AND ps_suppkey not IN (
        SELECT s_suppkey
        FROM supplier
        WHERE s_comment LIKE '%Customer%Complaints%')
GROUP BY p_brAND,p_type,p_size
ORDER BY supplier_cnt DESC, p_brAND, p_type, p_size;

-- EXECUTE q22('Brand#45', 'MEDIUM POLISHED%', 49, 14, 23, 45, 19, 3, 36, 9);


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

-- EXECUTE q23('13','31','23','29','30','18','17');
