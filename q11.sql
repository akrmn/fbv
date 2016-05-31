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