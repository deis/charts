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

# find the file where we reference the component
target_file="$(grep -rl "image: quay.io/deisci/${COMPONENT_NAME}:*" ${CHART_NAME})"

# replace the version with VERSION
file=""
for file in ${target_file}; do
  sed -i .bak "s%image: quay.io/deisci/${COMPONENT_NAME}:.*%image: quay.io/deisci/${COMPONENT_NAME}:${SHORT_VERSION}%" "${file}"
  echo "${CHART_NAME}: set ${COMPONENT_NAME} to ${SHORT_VERSION}"
done

# remove the backup file
find . -name "*.bak" | xargs -I {} rm {}

# print out the updated file just for kicks
echo -e "\t$(grep -r "image: quay.io/deisci/${COMPONENT_NAME}:${SHORT_VERSION}" ${target_file})"
