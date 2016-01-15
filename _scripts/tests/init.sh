#!/usr/bin/env bash

cd "$(dirname $0)"

source config.sh
source shared.sh

download-chart-mate
download-jq
