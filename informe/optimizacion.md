\newpage

# Optimización de las consultas

A continuación se presenta un análisis de las consultas a optimizar, el tiempo
que tardan y la mejora, de haberla, con respecto a la consulta original en
caso de ser una propuesta de optimización de la consulta.

Por razones de espacio no se colocarán los `explain plans` en este documento
pero si se desea consultar alguno de estos planes se encuentran almacenados
en la carpeta **results** tanto en formato YAML como en el formato estándar de salida
de postgres. Sin embargo, se podrán encontrar en este documento los planes de
ejecución de la consulta en formato gráfico para su fácil entendimiento.

En alguna consultas se realizaron estadísticas puntuales para ayudar a determinar,
junto con las estadísticas de la sección anterior, para proponer una optimización
más adecuada.

Es importante destacar que se trabajó con dos copias de la BD suministrada: una
sin modificación alguna y una segunda base de datos conde se crearon las estructuras
propuestas para la optimización de la consulta.

