#!/usr/bin/env bash

source _scripts/tests/shared.sh

download-chart-mate
download-jq

./rerun chart-mate:init
