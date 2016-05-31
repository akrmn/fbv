#!/usr/bin/env bash
psql -qAt -f e11.sql > analyze11.json
psql -qAt -f e12.sql > analyze12.json
psql -qAt -f e13.sql > analyze13.json
psql -qAt -f e21.sql > analyze21.json
psql -qAt -f e22.sql > analyze22.json
psql -qAt -f e23.sql > analyze23.json
