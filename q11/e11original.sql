\i q11original.sql

explain (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON)
execute q11original (15, '%BRASS', 'EUROPE');
