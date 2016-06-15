\i q13improved.sql
set work_mem = 65536;
EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS)
EXECUTE q13improved('1993-10-01');
