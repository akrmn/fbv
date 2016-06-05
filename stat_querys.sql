-- Consultas Generales acerca de la BD FBV

-- Cantidad de entradas en la BD
select sum(n_live_tup) 
    from pg_stat_user_tables 
    where schemaname='original';
    
-- Cantidad de entradas por cada tabla de la base de datos, número de páginas en la BD
-- y la relación entre el número de tuplas y la cantidad de páginas en dísco. 
select c.relname, n_live_tup, relpages, floor(n_live_tup/relpages::float) as tuples_per_page
    from pg_stat_user_tables b, pg_class c
    where relnamespace = (select oid from pg_namespace where nspname='original')
        and schemaname = 'original' 
        and b.relname= c.relname;
    
/* 
 relname  | n_live_tup | relpages | tuples_per_page
----------+------------+----------+-----------------
 part     |     200000 |     3715 |              53
 supplier |      10000 |      213 |              46
 partsupp |     800000 |    17451 |              45
 lineitem |    6001181 |    98544 |              60
 region   |          5 |        1 |               5
 nation   |         25 |        1 |              25
 customer |     150000 |     3566 |              42
 orders   |    1500000 |    25196 |              59 
 */
 
 -- Tamaño promedio de las tuplas de cada tabla
 select tablename,sum(avg_width) as tamanio_promedio_tuplas
    from pg_stats
    where schemaname='original'
    group by tablename;

/*  
tablename | tamanio_promedio_tuplas
-----------+-------------------------
 customer  |                     158
 orders    |                     100
 supplier  |                     137
 partsupp  |                     144
 region    |                      78
 nation    |                      91
 part      |                     114
 lineitem  |                      98
*/

-- Tamaño promedio de cada atributo, cantidad de atributos distintos y correlación
-- entre el orden físico y el orden lógico y el FR de cada fila. la consulta se ejecuca con un parámetro.

prepare stats_table as select  
    attname, 
    avg_width,
    (case 
        when n_distinct < 0  and n_distinct <> -1 then -n_distinct*t.reltuples
        else n_distinct
    end) as ndistinct, 
    correlation,
	most_common_freqs[1] as upper_bound, -- Es la máxima frecuencia para un atributo most_most_common_vals esta ordenado (Desc)
	(case 
        when n_distinct < 0 then -1/(n_distinct*t.reltuples)
        else 1/n_distinct
    end) as FR
    from pg_stats, (select relname,reltuples 
                        from pg_class 
                        where relnamespace = (select oid from pg_namespace where nspname='original')
                    ) t
    where 
        t.relname=tablename and
        tablename=$1 and
        schemaname = 'original';
		
--Ejecución para lineitem
execute stats_table('lineitem');

/*

*/

