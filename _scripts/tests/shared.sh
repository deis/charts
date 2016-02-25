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
