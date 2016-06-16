# Conclusiones

El proyecto sirvió para reforzar y poner en práctica lo aprendido en clase sobre el diseño físico y la optimización de consultas. Se experimentaron y utilizaron técnicas de optimización de consultas como la creación de índices compuestos, reescritura de consultas, clustering, particionamiento y gestión de memoria de trabajo y *shared buffers*.

Se empezó observando el esquema lógico de la base de datos y analizando los planes generados por las consultas originales. Se calcularon estadísticas que informaron sobre el tamaño y características de los datos. Para cada tabla se calculó el número de valores distintos, la correlación, la cota superior y la selectividad de cada uno de sus atributos. Estos datos fueron particularmente útiles para determinar la manera en que
se debían definir los índices, reescribir las consultas y particionar las tablas.

Cada integrante del equipo tomó una consulta de la primera parte y una de la segunda, y se analizaron todas las 6 consultas del proyecto. En general, todas consultas mostraron una mejora significativa luego del proceso de optimización. A continuación se muestran los porcentajes de mejora de cada una de las consultas:

| Consulta | Tiempo original (ms) | Tiempo optimizado (ms) | Porcentaje de mejora |
|----------|----------------------|------------------------|----------------------|
| Q11      | 1997.197             | 414.329                |                      |
| Q12      | 17932.438            | 2985.627               |                      |
| Q13      | 17875.401            | 2903.682               |                      |
| Q21      | 15858.726            | 3124.659               |                      |
| Q22      | 4392.969             | 2700.308               |                      |
| Q23      | 3019.109             | 379.253                |                      |

Como puede verse lo mucho que mejoraron las consultas, algunas mejorando hasta más del 90% sobre la consulta original. La mejora principal buscada en todas las consultas es crear índices para eliminar los *sequential scans* y sustituirlos por *index only scans*, los cuales son mucho más eficiente ya que solo consulta el índice y minimizan el número de I/Os necesarios, la causa principal del aumento de los tiempos de ejecución de las consultas. Al lograr que el plan de trabajo generera *index only scans*, se redujeron los tamaños y el optimizador seleccionó mejores algoritmos para realizar las operaciones `join`, y los únicos nodos que afectaban un poco los tiempos de ejecución fueron los de ordenamiento donde se utilizaron técnicas como el aumento de la memoria de trabajo para disminuir su impacto en el rendimiento de la consulta obteniendo así resultados favorables e ilustrando la importancia de la optimización como una de las tareas fundamentales para los administradores de bases de datos.
