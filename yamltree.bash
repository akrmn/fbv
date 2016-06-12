#!/usr/bin/env bash

grep "Node Type" results/analysis"$1".yml | sed "s/Node Type: \"\(.*\)\"/\1/g"  | sed "s/-/ /g" > trees/tree"$1".txt
