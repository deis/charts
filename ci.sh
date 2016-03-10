#!/usr/bin/env bash

set -eo pipefail

rm -rf ${HOME}/.chart-mate

export CI=true

trap "./rerun chart-mate:down" EXIT

_scripts/tests/install-chart-mate.sh

./rerun chart-mate:init
./rerun chart-mate:up
./rerun chart-mate:bumpver
./rerun chart-mate:install
./rerun chart-mate:check
./rerun chart-mate:test
