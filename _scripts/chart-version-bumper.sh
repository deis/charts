#!/usr/bin/env bash

set -eo pipefail

function usage() {
  cat <<EOF
$0 <chart name> <component name> <version>
EOF
}

if [ $# -ne 3 ]; then
  usage
  exit 1
fi

CHART_NAME="${1}"
COMPONENT_NAME="${2}"
VERSION="${3}"
SHORT_VERSION="${VERSION:0:7}" # short git hashes (what we use in registries) are the 7 characters
GIT_PREFIXED_TAG="git-${SHORT_VERSION}"

# find the file where we reference the component
target_file="$(grep -Erl "image: quay.io/[a-z]+/${COMPONENT_NAME}:*" ${CHART_NAME})"

echo "==> Operating on files: ${target_file}"

# replace the version with VERSION
file=""
for file in ${target_file}; do
  echo -e "\t${CHART_NAME}: set ${COMPONENT_NAME} to ${GIT_PREFIXED_TAG}"
  sed -E -i.bak "s%image: quay\.io/([a-z]+)/${COMPONENT_NAME}:.*%image: quay.io/\1/${COMPONENT_NAME}:${GIT_PREFIXED_TAG}%" "${file}"
done

# remove the backup file
find . -name "*.bak" | xargs -I {} rm {}

# print out the updated file just for kicks
echo
echo -e "\tVerification:"
echo -e "\t\t$(grep -Er "image: quay.io/[a-z]+/${COMPONENT_NAME}:${GIT_PREFIXED_TAG}" ${target_file})"
echo
