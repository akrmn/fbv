drop index idx_p_size_reverse_type;
\i q11original.sql

EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON)
EXECUTE q11Original (15, '%BRASS', 'EUROPE');
