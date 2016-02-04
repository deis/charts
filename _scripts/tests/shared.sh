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

  kubectl --namespace="${name}" get pods -o json | jq -r ".items[].status.phase" | grep -v "Succeeded" | grep -qv "Running"
}

function healthcheck-deis {
  wait-for-all-pods "deis"
  wait-for-http-status "http://deis.$(get-router-ip).xip.io/v2/" 200
}

function wait-for-all-pods {
  local name="${1}"

  echo "Waiting for all pods to be in running state..."
  wait-for-output ":" \
                  "! check-all-pods-running "${name}"" \
                  "All pods are running!" \
                  "Not all pods started." \
                  1
}

function wait-for-http-status {
  local url="${1}"
  local status="${2}"

  echo "Checking DNS (${url})..."
  wait-for-output "curl -s -o /dev/null -w '%{http_code}' "${url}"" \
                  "[ \${command_output} -eq 401 ]" \
                  "Deis is responding at ${url}." \
                  "Deis is unresponsive at ${url}" \
                  10
}

function get-router-ip {
  local ip="null"

  echo "Ensuring non-null router ip..." 1>&2
  wait-for-output "kubectl --namespace=deis get svc deis-router -o json | jq -r ".status.loadBalancer.ingress[0].ip"" \
                  "[ ! -z \${command_output} ] && [ \${command_output} != "null" ]" \
                  "\${command_output}" \
                  "Router never exposed public IP" \
                  10 60

}

function return-pod-exit-code {
  local name="${1}"
  local namespace="${2:-deis}"
  local status

  echo "Waiting for pod exit code..."
  local exit_code=$(wait-for-output "kubectl get po "${name}" -a --namespace="${namespace}" -o json | jq -r '.status.containerStatuses[0].state.terminated.exitCode'" \
                                    "[ \${command_output} != "null" ]" \
                                    "\${command_output}" \
                                    "100" \
                                    1 15)
  echo -e "\nExit code: ${exit_code}\n"
  return ${exit_code}
}

function wait-for-output {
  local run_this="${1}"
  local condition="${2}"

  local success_loop_msg=${3}
  local failed_loop_msg="${4}"

  local increment_secs="${5:-5}"
  local timeout_secs="${6:-120}"

  local command_output

  local waited_time=0
  while [ ${waited_time} -lt ${timeout_secs} ]; do
    command_output=$(eval ${run_this})

    if eval ${condition}; then
      eval echo ${success_loop_msg}
      return 0
    fi

    sleep ${increment_secs}
    (( waited_time += ${increment_secs} ))

    if [ ${waited_time} -ge ${timeout_secs} ]; then
      eval echo ${failed_loop_msg}
      return 1
    fi

    echo -n . 1>&2

  done
}
