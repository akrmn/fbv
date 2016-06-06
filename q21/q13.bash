#!/usr/bin/env bash

psql -qAt -f e21original.sql > a21original.yml
psql -qAt -f e21improved.sql > a21improved.yml