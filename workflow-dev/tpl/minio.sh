#!/bin/bash
store=`grep "storage = " $HELM_GENERATE_DIR/tpl/generate_params.toml |cut -d "=" -f2 | tr -dc '[:alnum:]\n\r'`
if [ -n "$STORAGE_TYPE" ]; then
  if [ "$STORAGE_TYPE" != "minio" ]; then
    rm -rf $HELM_GENERATE_DIR/manifests/deis-minio-*
  fi
elif [ "$store" != "minio" ]; then
  rm -rf $HELM_GENERATE_DIR/manifests/deis-minio-*
else
  helmc tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-minio-rc.yaml $HELM_GENERATE_DIR/tpl/deis-minio-rc.yaml
  cp $HELM_GENERATE_DIR/tpl/deis-minio-service* $HELM_GENERATE_DIR/manifests/
fi
