\i q21original.sql

EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT YAML)
EXECUTE q21o('MAIL', 'SHIP', '1994-01-01');
