\i q23improved.sql

explain (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON)
execute q23improved ('13','31','23','29','30','18','17');
