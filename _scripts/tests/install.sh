#!/usr/bin/env bash

cd "$(dirname $0)"

source config.sh
source shared.sh

rm -rf ~/.helm/
helm repo add deis https://github.com/deis/charts
helm up
helm fetch deis/deis-dev
helm generate deis-dev
helm install deis-dev
