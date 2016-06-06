#!/usr/bin/env bash

service postgresql stop
sysctl vm.drop_caches=3
service postgresql start
