\i q11improved.sql

explain (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON)
execute q11improved (15, '%BRASS', 'EUROPE');
