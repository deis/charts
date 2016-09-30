#!/bin/bash

set -euo pipefail

CHARTS="${CHARTS:-workflow-dev workflow-dev-e2e router-dev}"

for chart in $CHARTS; do
    new_chart=${chart/-dev/-$WORKFLOW_RELEASE}
    echo "Creating $new_chart from $chart..."

    # copy the workflow family of charts to their new home
    cp -R -n "$chart"/ "$new_chart" || \
        echo "Failed to copy files. Does $new_chart already exist?"

    # update the controller deployment manifest
    for f in $(find "$new_chart" -name deis-controller-deployment.yaml); do
        # remove the k8s pod termination variable line and the one after
        sed -i '' -e '/KUBERNETES_POD_TERMINATION_GRACE_PERIOD_SECONDS/,/^/d' "$f"
    done

    # update the documentation files for production
    for f in $(find "$new_chart" -name README.md -o -name Chart.yaml); do
        # remove "WARNING: for testing only" lines
        sed -i '' -e '/WARNING:/,/^/d' "$f"
        sed -i '' -e 's/ (For testing only!)//g' "$f"
        # collapse multiple blank lines into one
        sed -i '' -e '/^$/N;/^\n$/D' "$f"
        # replace all "dev" references with $WORKFLOW_RELEASE
        sed -i '' -e "s/ dev/ $WORKFLOW_RELEASE/g" "$f"
        sed -i '' -e "s/-dev/-$WORKFLOW_RELEASE/g" "$f"
    done

    # update the TOML parameters files
    for f in $(find "$new_chart" -name generate_params.toml); do
        # update all org values to "deis"
        sed -i '' -e 's/"deisci"/"deis"/g' "$f"
        # update the image pull policy to "IfNotPresent"
        sed -i '' -e 's/"Always"/"IfNotPresent"/g' "$f"
        # update the workflow manager URLs to production
        sed -i '' -e 's/versions-staging/versions/g' "$f"
        sed -i '' -e 's/doctor-staging/doctor/g' "$f"
        # replace all "-dev" references with $WORKFLOW_RELEASE
        sed -i '' -e "s/-dev/-$WORKFLOW_RELEASE/g" "$f"
        # warn user to put semver tags in the generate_params.toml files
        sed -i '' -e 's/"canary"/"CHANGEME"/g' "$f"
        echo "$f needs semver values in \"dockerTag\" fields!"
    done

done
