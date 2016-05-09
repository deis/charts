#!/bin/bash
while IFS='' read -r line || [[ -n "$line" ]]; do
  if [[ $line == "storage"* ]]; then
    IFS='=' read -a storage <<< "$line"
    if [ ${storage[1]} == "\"minio\"" ]; then
      helm tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-minio-rc.yaml $HELM_GENERATE_DIR/tpl/deis-minio-rc.yaml
      cp $HELM_GENERATE_DIR/tpl/deis-minio-service* $HELM_GENERATE_DIR/manifests/
    else
      rm -rf $HELM_GENERATE_DIR/manifests/deis-minio-*
    fi
  fi
done < "$HELM_GENERATE_DIR/tpl/generate_params.toml"
