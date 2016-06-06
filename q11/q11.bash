#!/usr/bin/env bash

psql -qAt -f e11original.sql > a11original.json
psql -qAt -f e11improved.sql > a11improved.json
