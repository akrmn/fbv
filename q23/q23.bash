#!/usr/bin/env bash

echo "Consulta original"
echo "  Borrando índices"
psql -qAt -f d23.sql > /dev/null
echo "  Limpiando cache"
sudo ../clearcache.bash > /dev/null
echo "  Ejecutando consulta original"
psql -qAt -f e23original.sql > a23original.json
echo "Consulta original completa"

echo

echo "Consulta mejorada"
echo "  Creando índices"
psql -qAt -f i23.sql > /dev/null
echo "  Limpiando cache"
sudo ../clearcache.bash > /dev/null
echo "  Ejecutando consulta mejorada"
psql -qAt -f e23improved.sql > a23improved.json
echo "Consulta mejorada completa"
