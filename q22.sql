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