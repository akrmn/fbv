#!/usr/bin/env bash

psql -qAt -f e13.sql > a13original.yml
psql -qAt -f e13improved.sql > a13improved.yml