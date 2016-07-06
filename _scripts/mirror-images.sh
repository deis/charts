#!/bin/bash

# this script is built to pull Deis Worfklow release images, re-tag them and
# subsequently push the images to a new repository

# Usage: MIRROR_DESTINATION=quay.io/jhansen ./_script/mirror-images.sh

# Override the version and source locations by setting the following
# environment variables:
WORKFLOW_IMAGE_SOURCE=${WORKFLOW_IMAGE_SOURCE:-quay.io}
WORKFLOW_IMAGE_ORG=${WORKFLOW_IMAGE_ORG:-deis}
WORKFLOW_RELEASE=${WORKLFOW_RELEASE:-v2.1.0}

if [[ -z ${MIRROR_DESTINATION} ]]; then
        echo "You must specify MIRROR_DESTINATION in your enviroment"
        exit 1
fi

for image in builder \
        controller \
        dockerbuilder \
        fluentd \
        logger \
        minio \
        monitor \
        postgres \
        registry \
        router \
        slugbuilder \
        slugrunner \
        stdout-metrics \
        workflow \
        workflow-manager; do

        source_image=${WORKFLOW_IMAGE_SOURCE}/${WORKFLOW_IMAGE_ORG}/$image:${WORKFLOW_RELEASE}
        dest_image=${MIRROR_DESTINATION}/${image}:${WORKFLOW_RELEASE}

        echo "Pulling image: ${source_image}"
        docker pull ${source_image}

        echo "Re-tagging image: ${source_image} to ${dest_image}"
        docker tag ${source_image} ${dest_image}

        echo "Pushing image: ${dest_image}"
        docker push ${dest_image}
done
