\i q11improved.sql

explain (ANALYZE, COSTS, VERBOSE, BUFFERS)
execute q11improved (15, '%BRASS', 'EUROPE');
