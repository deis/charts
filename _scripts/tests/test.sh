#!/usr/bin/env bash

cd "$(dirname $0)"

source config.sh
source shared.sh

helm fetch deis/deis-tests
helm uninstall -n deis -y deis-tests; helm install deis-tests

wait-for-all-pods "deis"
kubectl --namespace=deis logs -f deis-tests
return-pod-status "deis-tests"
