--índices para las consulta 22

create index idx_q22_part on part (p_brand, p_type, p_size);
create index idx_q22_supplier on supplier (s_suppkey);