\i q22original.sql

explain (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT YAML)
execute q22original ('Brand#45', 'MEDIUM POLISHED%', 49, 14, 23, 45, 19, 3, 36, 9);
