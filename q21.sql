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