-- Consultas Generales acerca de la BD FBV

-- Cantidad de entradas en la BD
select sum(n_live_tup) 
    from pg_stat_user_tables;
    
-- Cantidad de entradas por cada tabla de la base de datos, número de páginas en la BD
-- y la relación entre el número de tuplas y la cantidad de páginas en dísco. 
select c.relname, n_live_tup, relpages, floor(n_live_tup/relpages::float) as tuples_per_page
    from pg_stat_user_tables b, pg_class c
    where b.relname= c.relname;
    
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
    where tablename in (select relname from pg_stat_user_tables)
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
                        where relname=$1
                    ) t
    where 
        t.relname=tablename 
    order by fr;
        
--Evaluación de lineitem
execute stats_table('lineitem');

/*
     attname     | avg_width |  ndistinct  | correlation  | upper_bound |          fr
-----------------+-----------+-------------+--------------+-------------+----------------------
 l_shipdate      |         4 |        2525 |  -0.00126623 | 0.000536667 | 0.000396039603960396
 l_shipinstruct  |        13 |           4 |     0.250591 |    0.250767 |                 0.25
 l_shipmode      |         5 |           7 |     0.145059 |    0.143523 |    0.142857142857143
 l_quantity      |         5 |          50 |    0.0195651 |   0.0205067 |                 0.02
 l_extendedprice |         8 |      767024 |  0.000341259 | 2.33333e-05 | 1.30374016979912e-06
 l_discount      |         4 |          11 |    0.0868008 |   0.0922367 |   0.0909090909090909
 l_tax           |         4 |           9 |     0.109181 |     0.11199 |    0.111111111111111
 l_returnflag    |         2 |           3 |     0.377041 |    0.506517 |    0.333333333333333
 l_linestatus    |         2 |           2 |     0.499747 |    0.500087 |                  0.5
 l_commitdate    |         4 |        2465 |  -0.00119272 | 0.000536667 | 0.000405679513184584
 l_receiptdate   |         4 |        2543 |  -0.00128363 | 0.000553333 | 0.000393236335037357
 l_comment       |        27 | 1.76369e+06 |  0.000151724 | 0.000193333 | 5.66991779753177e-07
 l_orderkey      |         4 | 1.20633e+06 |            1 | 1.66667e-05 | 8.28960566345859e-07
 l_partkey       |         4 |      197029 |   0.00235099 |       3e-05 |  5.0753949926153e-06
 l_suppkey       |         4 |       10000 | -0.000106049 | 0.000173333 |               0.0001
 l_linenumber    |         4 |           7 |     0.176068 |    0.250317 |    0.142857142857143
*/

--Evaluación para orders
execute stats_table('orders');
/* 
   attname     | avg_width |  ndistinct  | correlation | upper_bound |          fr
-----------------+-----------+-------------+-------------+-------------+----------------------
 o_orderkey      |         4 |          -1 |    0.999999 |             | 6.66666666666667e-07
 o_comment       |        49 | 1.46105e+06 | 0.000667332 | 1.33333e-05 | 6.84438336212537e-07
 o_totalprice    |         8 | 1.43966e+06 |  0.00179892 |       1e-05 | 6.94609896662886e-07
 o_custkey       |         4 |       96824 |  0.00212814 | 4.66667e-05 | 1.03280178468148e-05
 o_orderdate     |         4 |        2406 |  0.00254059 |     0.00056 | 0.000415627597672485
 o_clerk         |        16 |        1000 | 0.000855419 |     0.00118 |                0.001
 o_orderpriority |         9 |           5 |    0.201246 |    0.201113 |                  0.2
 o_orderstatus   |         2 |           3 |    0.476312 |    0.488067 |    0.333333333333333
 o_shippriority  |         4 |           1 |           1 |           1 |                    1

 */
 
 --Evaluacion para customer
 execute stats_table('customer');
 /*
  attname    | avg_width | ndistinct | correlation  | upper_bound |          fr
--------------+-----------+-----------+--------------+-------------+----------------------
 c_phone      |        16 |        -1 |  0.000497003 |             | 6.66666666666667e-06
 c_custkey    |         4 |        -1 |     0.999988 |             | 6.66666666666667e-06
 c_name       |        19 |        -1 |     0.999988 |             | 6.66666666666667e-06
 c_address    |        26 |        -1 |    0.0011718 |             | 6.66666666666667e-06
 c_comment    |        73 |    149968 | -0.000241386 | 1.33333e-05 | 6.66808919236104e-06
 c_acctbal    |         6 |    140187 |   0.00410825 | 2.66667e-05 |  7.1333290533359e-06
 c_nationkey  |         4 |        25 |    0.0405429 |   0.0410733 |                 0.04
 c_mktsegment |         9 |         5 |     0.200573 |     0.20126 |                  0.2

 */
 
 -- Evaluacion para part
 execute stats_table('part');
/*
     attname    | avg_width | ndistinct | correlation  | upper_bound |          fr
---------------+-----------+-----------+--------------+-------------+----------------------
 p_partkey     |         4 |        -1 |     0.999905 |             |                5e-06
 p_name        |        33 |    199997 | -0.000591865 |       1e-05 | 5.00007500112502e-06
 p_comment     |        14 |    131753 |  -0.00166307 |    0.000615 | 7.58996000091079e-06
 p_retailprice |         6 |     20899 |     0.192004 |             | 4.78491793865735e-05
 p_type        |        21 |       150 |    0.0095101 |    0.007255 |  0.00666666666666667
 p_size        |         4 |        50 |    0.0237148 |    0.020885 |                 0.02
 p_container   |         8 |        40 |    0.0252164 |    0.025765 |                0.025
 p_brand       |         9 |        25 |    0.0414318 |    0.041165 |                 0.04
 p_mfgr        |        15 |         5 |     0.201261 |     0.20152 |                  0.2
 */
 
 -- Evaluacion para partsupp
  execute stats_table('partsupp');
/*
    attname    | avg_width | ndistinct | correlation  | upper_bound |          fr
---------------+-----------+-----------+--------------+-------------+----------------------
 ps_comment    |       126 |    798569 |  0.000561844 | 6.66667e-06 | 1.25223994420019e-06
 ps_partkey    |         4 |    200105 |     0.999993 | 1.33333e-05 | 4.99737637740186e-06
 ps_supplycost |         6 |     97978 | -0.000937153 |       4e-05 | 1.02063728592133e-05
 ps_suppkey    |         4 |     10000 |   0.00181275 | 0.000156667 |               0.0001
 ps_availqty   |         4 |      9999 |   0.00135311 |     0.00018 |   0.0001000100010001

*/  
  
  -- Evaluación para supplier
  execute stats_table('supplier');
  
/*
  attname   | avg_width | ndistinct | correlation | upper_bound |          fr
-------------+-----------+-----------+-------------+-------------+----------------------
 s_address   |        25 |        -1 | 0.000978475 |             |               0.0001
 s_suppkey   |         4 |        -1 |    0.999954 |             |               0.0001
 s_name      |        19 |        -1 |    0.999954 |             |               0.0001
 s_phone     |        16 |        -1 |  0.00634556 |             |               0.0001
 s_comment   |        63 |        -1 | -0.00867227 |             |               0.0001
 s_acctbal   |         6 |      9955 |   0.0158685 |      0.0002 | 0.000100452034153692
 s_nationkey |         4 |        25 |   0.0458266 |      0.0438 |                 0.04

*/

-- Evaluación para nation
  execute stats_table('nation');
  
/*
   attname   | avg_width | ndistinct | correlation | upper_bound |  fr
-------------+-----------+-----------+-------------+-------------+------
 n_comment   |        75 |        -1 |   0.0469231 |             | 0.04
 n_nationkey |         4 |        -1 |           1 |             | 0.04
 n_name      |         8 |        -1 |    0.913077 |             | 0.04
 n_regionkey |         4 |         5 |    0.347692 |         0.2 |  0.2

*/

-- Evaluación para region
	execute stats_table('nation');
/*
   attname   | avg_width | ndistinct | correlation | upper_bound | fr
-------------+-----------+-----------+-------------+-------------+-----
 r_regionkey |         4 |        -1 |           1 |             | 0.2
 r_name      |         7 |        -1 |           1 |             | 0.2
 r_comment   |        67 |        -1 |         0.6 |             | 0.2

*/
  