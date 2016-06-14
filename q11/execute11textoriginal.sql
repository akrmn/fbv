\i q11original.sql

explain (ANALYZE, COSTS, VERBOSE, BUFFERS)
execute q11original (15, '%BRASS', 'EUROPE');
