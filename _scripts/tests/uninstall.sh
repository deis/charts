#!/usr/bin/env bash

cd "$(dirname $0)"

source config.sh
source shared.sh

helm uninstall -n deis -y deis-dev;
