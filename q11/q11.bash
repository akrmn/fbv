#!/usr/bin/env bash

echo "Consulta original"
echo "  Borrando índices"
psql -qAt -f d11.sql > /dev/null
echo "  Limpiando cache"
sudo ../clearcache.bash > /dev/null
echo "  Ejecutando consulta original"
psql -qAt -f e11original.sql > a11original.json
echo "Consulta original completa"

echo

echo "Consulta mejorada"
echo "  Creando índices"
psql -qAt -f i11.sql > /dev/null
echo "  Limpiando cache"
sudo ../clearcache.bash > /dev/null
echo "  Ejecutando consulta mejorada"
psql -qAt -f e11improved.sql > a11improved.json
echo "Consulta mejorada completa"
