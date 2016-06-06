#!/usr/bin/env bash

# Consulta original
## Borrar índices
psql -qAt -f d23.sql > /dev/null
## Limpiar cache
sudo ../clearcache.bash
## Correr consulta, guardando resultado
psql -qAt -f e23original.sql > a23original.json

# Consulta Mejorada
## Crear índices
psql -qAt -f i23.sql > /dev/null
## Limpiar Cache
sudo ../clearcache.bash
## Correr consulta, guardando resultado
psql -qAt -f e23improved.sql > a23improved.json
