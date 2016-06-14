#!/usr/bin/env bash

echo q"$1"

cd q"$1"

echo "Consulta original"
echo "  Limpiando cache"
sudo ../clearcache.bash > /dev/null
echo "  Ejecutando consulta original"
psql -d original -qAt -f execute"$1"textoriginal.sql > ../results/analysis"$1"original.txt
echo "Consulta original completa"

echo

echo "Consulta mejorada"
echo "  Creando índices"
psql -qAt -f indices"$1".sql > /dev/null
echo "  Limpiando cache"
sudo ../clearcache.bash > /dev/null
echo "  Ejecutando consulta mejorada"
psql -qAt -f execute"$1"textimproved.sql > ../results/analysis"$1"improved.txt
echo "Consulta mejorada completa"

echo

cd ..
