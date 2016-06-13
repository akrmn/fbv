#!/usr/bin/env bash

echo q"$1"

cd q"$1"

echo "Consulta original"
echo "  Limpiando cache"
sudo ../clearcache.bash > /dev/null
echo "  Ejecutando consulta original"
psql -d original -qAt -f execute"$1"original.sql > ../results/analysis"$1"original.yml
echo "Consulta original completa"

echo

echo "Consulta mejorada"
echo "  Creando índices"
psql -qAt -f indices"$1".sql > /dev/null
echo "  Limpiando cache"
sudo ../clearcache.bash > /dev/null
echo "  Ejecutando consulta mejorada"
psql -qAt -f execute"$1"improved.sql > ../results/analysis"$1"improved.yml
echo "Consulta mejorada completa"

echo

cd ..
