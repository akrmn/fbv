\i q11improved.sql

explain (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT YAML)
execute q11improved (15, '%BRASS', 'EUROPE');
