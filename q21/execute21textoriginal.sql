\i q21original.sql

EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS)
EXECUTE q21o('MAIL', 'SHIP', '1994-01-01');