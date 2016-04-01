#!/usr/bin/env bash

set -eo pipefail

rm -rf ${HOME}/.chart-mate

trap "./rerun chart-mate:down" EXIT

_scripts/tests/install-chart-mate.sh

unset SUDO_USER # https://github.com/rerun/rerun/issues/222
./rerun chart-mate:init
./rerun chart-mate:up
./rerun chart-mate:bumpver
./rerun chart-mate:install
./rerun chart-mate:check
./rerun chart-mate:test
