#!/usr/bin/env bash

# Consulta original
## Borrar índices
psql -qAt -f d11.sql > /dev/null
## Limpiar cache
sudo ../clearcache.bash
## Correr consulta, guardando resultado
psql -qAt -f e11original.sql > a11original.json

# Consulta Mejorada
## Crear índices
psql -qAt -f i11.sql > /dev/null
## Limpiar Cache
sudo ../clearcache.bash
## Correr consulta, guardando resultado
psql -qAt -f e11improved.sql > a11improved.json
