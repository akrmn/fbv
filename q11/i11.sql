create index idx_p_size_reverse_type
  on part (p_size, reverse(p_type) text_pattern_ops);
