#!/usr/bin/env bash

sudo ../clearcache.bash
psql -qAt -f e23original.sql > a23original.json
sudo ../clearcache.bash
psql -qAt -f e23improved.sql > a23improved.json
