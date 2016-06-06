#!/usr/bin/env bash

sudo ../clearcache.bash
psql -qAt -f e11original.sql > a11original.json
sudo ../clearcache.bash
psql -qAt -f e11improved.sql > a11improved.json
