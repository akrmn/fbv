\i q12original.sql

explain (ANALYZE, COSTS, VERBOSE, BUFFERS)
execute q12original ('BUILDING', '1995-03-15');
