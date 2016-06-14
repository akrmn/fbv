\i q12improved.sql

explain (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT YAML)
execute q12improved ('BUILDING', '1995-03-15');
