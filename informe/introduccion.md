---
papersize: letter
geometry: margin=1in
documentclass: article
fontsize: 12pt
toc: true
toc-depth: 3
fignos-caption-name: Figura
fignos-cleveref: On
fignos-plus-name: la\ Figura
fignos-star-name: La\ Figura
tablenos-caption-name: Tabla
tablenos-cleveref: On
tablenos-plus-name: la\ Tabla
tablenos-star-name: La\ Tabla
...

\newpage

# Introducción

Una Base de datos comienza con un problema en el cual se quieren
almacenar datos de forma persistente. De este problema y su universo que se
suele llamar «minimundo» surge un modelo lógico que, después de varias
iteraciones, representa de la forma mas exacta posible el problema ( o al menos
lo relacionado con almacenamiento de datos).

Luego del modelado, el siguiente paso es llevar ese modelo lógico a uno mas
concreto. En este paso se crean entonces todas las tablas y relaciones entre
las mismas, se declaran las resticciónes y se determinan los disparadores
que tendrá la base de datos.

Cuando termina toda la fase transformación del modelo lógico a físico (o de más
bajo nivel), se podría decir que la Base de datos esta lista para recibir datos.
Mientras el volumen de datos sea pequeño, el manejador encargado de realizar
las consultas, actualizaciones o transacciones puede manejar con relativa facilidad
los datos. Sin embargo, las bases de datos tienen a crecer más que a quedarse
estáticas y, cuando esto ocurre, algunas operaciones pueden tornarse costosas.

Afortunadamente, los sistemas manejadores de bases de datos proveen estructuras
y facilidades para optimizar estas operaciones.Se tienen, entre las más famosas
para optimizar consultas, indices, tablas particionadas o ajuste de parámetros como
memoria. Estas estructuras, no obstante, deben ser
especificadas por el usuario encargado del buen funcionamiento de la base de datos.

Las estadísticas de cada tabla juegan un papel importante en la elección de un
mejor plan de ejecución por parte del manejador de la base de datos y para la elección de una estructura
auxiliar. Las estadísticas tambíen le dicen mucho al administrador de la base de
datos acerca de qué estructura se debe crear para optimizar un grupo de consultas
u operaciones sobre la base de datos.

El presente informe tiene como finalidad describir el comportamiento de estructuras
de optimización de consultas ante una Báse de datos de un tamaño considerablemente
grande sobre la cuál se deben optimizar ciertas consultas. Para optimizar estas
consultas, el úso de los conocimientos teóricos acerca de optimización de consultas, las estadísticas
que se puedan obtener del manejador, las que se puedan derivar de estas y serán
las herramientas para determinar que estructuras se deberían usar o no en alguna
de las consultas planteadas.






