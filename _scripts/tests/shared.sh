set -eo pipefail

PLATFORM="$(uname | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

function check_platform_arch {
  local supported="linux-amd64 linux-i386 darwin-amd64 darwin-i386"

  if ! echo "${supported}" | tr ' ' '\n' | grep -q "${PLATFORM}-${ARCH}"; then
    cat <<EOF

${PROGRAM} is not currently supported on ${PLATFORM}-${ARCH}.

See https://github.com/deis/${PROGRAM} for more information.

EOF
  fi
}

function download-jq {
  if ! command -v jq &>/dev/null && [ "${PLATFORM}" == linux ]; then
    echo "Downloading jq..."
    mkdir -p .bin
    curl -Ls https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 > .bin/jq
    chmod +x .bin/jq
  fi
}

function get_latest_version {
  local name="${1}"
  local url="${2}"

  local version
  version="$(curl -sI "${url}" | grep "Location:" | sed -n "s%.*${name}/%%;s%/view.*%%p" )"

  if [ -z "${version}" ]; then
    echo "There doesn't seem to be a version of ${name} avaiable at ${url}." 1>&2
    return 1
  fi

  url_decode "${version}"
}

function url_decode {
  local url_encoded="${1//+/ }"
  printf '%b' "${url_encoded//%/\\x}"
}

function download-chart-mate {
  RERUN_MODULES_REPO="${RERUN_MODULES_REPO:-"rerun-modules"}"
  CHART_MATE_REPO_URL="https://bintray.com/sgoings/${RERUN_MODULES_REPO}/chart-mate/_latestVersion"
  CHART_MATE_URL_BASE="https://dl.bintray.com/sgoings/${RERUN_MODULES_REPO}"

  VERSION="$(get_latest_version "chart-mate" "${CHART_MATE_REPO_URL}")"

  echo "Downloading chart-mate from Bintray (${VERSION})..."
  curl -Ls "${CHART_MATE_URL_BASE}/rerun-${VERSION}" > rerun
  chmod +x rerun
}

function check-all-pods-running {
  local namespace="${1:-deis}"

  kubectl --namespace="${name}" get pods -o json | jq -r ".items[].status.phase" | grep -qv "Running"
}

function healthcheck-deis {
  wait-for-all-pods "deis"
  wait-for-http-status http://deis.$(get-router-ip).xip.io/v2/ 200
}

function wait-for-all-pods {
  local name="${1}"

  HEALTHCHECK_TIMEOUT_SEC=120
  WAIT_TIME=1
  echo "Waiting for all pods to be in running state..."
  while check-all-pods-running "${name}"; do
    sleep 1
    (( WAIT_TIME += 1 ))
    if [ ${WAIT_TIME} -gt ${HEALTHCHECK_TIMEOUT_SEC} ]; then
      echo
      return 1
    fi
    echo -n .
  done
  echo "All pods are running!"
}

function wait-for-http-status {
  local url="${1}"
  local status="${2}"

  echo "Checking DNS (${url})..."

  HEALTHCHECK_TIMEOUT_SEC=120
  WAIT_TIME=10
  while [ "401" != "$(curl -s -o /dev/null -w '%{http_code}' "${url}")" ]; do
    sleep 10
    (( WAIT_TIME += 10 ))
    if [ ${WAIT_TIME} -gt ${HEALTHCHECK_TIMEOUT_SEC} ]; then
      echo
      return 1
    fi
    echo -n .
  done
  echo "Deis is responding at ${url}."
}

function get-router-ip {
  local ip="null"

  echo "Ensuring non-null router ip..." 1>&2

  TIMEOUT_SECS=120
  WAIT_TIME=10
  while [ ${WAIT_TIME} -lt ${TIMEOUT_SECS} ]; do
    ip="$(kubectl --namespace=deis get svc deis-router -o json | jq -r ".status.loadBalancer.ingress[0].ip")"
    if [ "${ip}" != null ]; then
      break
    fi
    sleep 10
    (( WAIT_TIME += 10 ))
    if [ ${WAIT_TIME} -gt ${TIMEOUT_SECS} ]; then
      return 1
    fi
  done

  echo "${ip}"
}

function return-pod-status {
  local name="${1}"
  local namespace="${2:-deis}"
  local status

  echo "Waiting for pod container exit code..."
  TIMEOUT_SECS=10
  WAIT_TIME=1
  while [ ${WAIT_TIME} -lt ${TIMEOUT_SECS} ]; do
    status="$(kubectl get po "${name}" -a --namespace="${namespace}" -o json | jq -r '.status.containerStatuses[0].state.terminated.exitCode')"
    if [ "${status}" != null ]; then
      echo "Exit code: ${status}"
      return ${status}
    fi
    sleep 1
    (( WAIT_TIME += 1 ))
    if [ ${WAIT_TIME} -gt ${TIMEOUT_SECS} ]; then
      echo "Exit code: unable to determine"
      return 1
    fi
    echo -n .
  done
}
