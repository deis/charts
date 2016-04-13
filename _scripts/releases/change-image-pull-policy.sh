#!/usr/bin/env bash

sed -i.bak \
"s/imagePullPolicy: ${SOURCE_IMAGE_PULL_POLICY}/imagePullPolicy: ${TARGET_IMAGE_PULL_POLICY}/" \
${SOURCE_FILE}
