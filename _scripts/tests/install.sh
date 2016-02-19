#!/usr/bin/env bash

cd "$(dirname $0)"

source config.sh
source shared.sh

function bumpver-if-set {
  local chart="${1}"
  local component="${2}"
  local version="${3}"

  if [ ! -z "${version}" ]; then
    local version_bumper="_scripts/chart-version-bumper.sh"
    "${version_bumper}" "${chart}" "${component}" "${version}"
  else
    echo "No version set for ${chart}: ${component}"
  fi
}

if [ ! -z $CI ]; then
  echo "INJECTING VERSIONS!"
  echo "-------------------"
  pushd ../../ &> /dev/null
  bumpver-if-set "deis-logger" "logger" "${LOGGER_GIT_SHA}"
  bumpver-if-set "deis-dev" "builder" "${BUILDER_GIT_SHA}"
  bumpver-if-set "deis-dev" "minio" "${MINIO_GIT_SHA}"
  bumpver-if-set "deis-dev" "postgres" "${POSTGRES_GIT_SHA}"
  bumpver-if-set "deis-dev" "registry" "${REGISTRY_GIT_SHA}"
  bumpver-if-set "deis-dev" "router" "${ROUTER_GIT_SHA}"
  bumpver-if-set "deis-dev" "workflow" "${WORKFLOW_GIT_SHA}"
  popd &> /dev/null
  echo "-------------------"
fi

rm -rf ~/.helm/
helm doctor
mkdir -p ~/.helm/cache/charts/deis
rsync -av ../../ ${HOME}/.helm/cache/deis/ > /dev/null
helm fetch deis/deis-dev
helm fetch deis/deis-logger

test_root="$(dirname $(pwd))"

helm generate deis-dev
helm install deis-dev
