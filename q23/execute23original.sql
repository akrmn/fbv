\i q23original.sql

explain (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT YAML)
execute q23original ('13','31','23','29','30','18','17');
