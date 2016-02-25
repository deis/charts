#!/usr/bin/env bash

source _scripts/tests/shared.sh

download-chart-mate

./rerun chart-mate:init
