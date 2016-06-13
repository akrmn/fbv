--índices para las consulta 11

create index if not exists idx_q11_p_size_reverse_type
  on part (p_size, reverse(p_type) text_pattern_ops);

create index if not exists idx_q11_partsupp
  on partsupp (ps_partkey, ps_suppkey, ps_supplycost);
