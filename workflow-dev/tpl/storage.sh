#!/bin/bash
store=`grep "storage\s*=\s*" $HELM_GENERATE_DIR/tpl/generate_params.toml | cut -d "=" -f2 | tr -dc '[:alnum:]\n\r'`
if [ "$STORAGE_TYPE" = "minio" ] || ( [ -z "$STORAGE_TYPE" ] && [ "$store" = "minio" ] ); then
  helmc tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-minio-deployment.yaml $HELM_GENERATE_DIR/tpl/deis-minio-deployment.yaml
  cp $HELM_GENERATE_DIR/tpl/deis-minio-service* $HELM_GENERATE_DIR/manifests/
else
  rm -rf $HELM_GENERATE_DIR/manifests/deis-minio-*
fi

database_location=`grep "database_location\s*=\s*" $HELM_GENERATE_DIR/tpl/generate_params.toml | cut -d "=" -f2 | tr -dc '[:alnum:]-\n\r'`
if [ "$DATABASE_LOCATION" = "on-cluster" ] || ( [ -z "$DATABASE_LOCATION" ] && [ "$database_location" = "on-cluster" ] ); then
  helmc tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-database-deployment.yaml $HELM_GENERATE_DIR/tpl/deis-database-deployment.yaml
  cp $HELM_GENERATE_DIR/tpl/deis-database-service* $HELM_GENERATE_DIR/manifests/
else
  rm -rf $HELM_GENERATE_DIR/manifests/deis-database-*
fi
helmc tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-database-secret-creds.yaml $HELM_GENERATE_DIR/tpl/deis-database-secret-creds.yaml

logger_redis_location=`grep "logger_redis_location\s*=\s*" $HELM_GENERATE_DIR/tpl/generate_params.toml | cut -d "=" -f2 | tr -dc '[:alnum:]-\n\r'`
if [ "$LOGGER_REDIS_LOCATION" = "on-cluster" ] || ( [ -z "$LOGGER_REDIS_LOCATION" ] && [ "$logger_redis_location" = "on-cluster" ] ); then
  helmc tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-logger-redis-deployment.yaml $HELM_GENERATE_DIR/tpl/deis-logger-redis-deployment.yaml
  cp $HELM_GENERATE_DIR/tpl/deis-logger-redis-service* $HELM_GENERATE_DIR/manifests/
else
  rm -rf $HELM_GENERATE_DIR/manifests/deis-logger-redis-*
fi
helmc tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-logger-redis-secret-creds.yaml $HELM_GENERATE_DIR/tpl/deis-logger-redis-secret-creds.yaml

registry_location=`grep "registry_location\s*=\s*" $HELM_GENERATE_DIR/tpl/generate_params.toml | cut -d "=" -f2 | tr -dc '[:alnum:]-\n\r'`
rm -rf $HELM_GENERATE_DIR/manifests/deis-registry-*
if [ "$REGISTRY_LOCATION" = "on-cluster" ] || ( [ -z "$REGISTRY_LOCATION" ] && [ "$registry_location" = "on-cluster" ] ); then
  helmc tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-registry-rc.yaml $HELM_GENERATE_DIR/tpl/deis-registry-rc.yaml
  helmc tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-registry-deployment.yaml $HELM_GENERATE_DIR/tpl/deis-registry-deployment.yaml
  helmc tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-registry-proxy.yaml $HELM_GENERATE_DIR/tpl/deis-registry-proxy-daemon.yaml
  cp $HELM_GENERATE_DIR/tpl/deis-registry-service* $HELM_GENERATE_DIR/manifests/
else
  helmc tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-registry-secret.yaml $HELM_GENERATE_DIR/tpl/deis-registry-secret.yaml
  if ([ "$REGISTRY_LOCATION" != "" ] && [ "$REGISTRY_LOCATION" != "off-cluster" ] ) || ( [ -z "$REGISTRY_LOCATION" ] && [ "$registry_location" != "off-cluster" ] ); then
    helmc tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-registry-token-refresher.yaml $HELM_GENERATE_DIR/tpl/deis-registry-token-refresher.yaml
  fi
fi

influxdb_location=`grep "influxdb_location\s*=\s*" $HELM_GENERATE_DIR/tpl/generate_params.toml | cut -d "=" -f2 | tr -dc '[:alnum:]-\n\r'`
if [ "$INFLUXDB_LOCATION" = "on-cluster" ] || ( [ -z "$INFLUXDB_LOCATION" ] && [ "$influxdb_location" = "on-cluster" ] ); then
  helmc tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-monitor-influxdb-deployment.yaml $HELM_GENERATE_DIR/tpl/deis-monitor-influxdb-deployment.yaml
  cp $HELM_GENERATE_DIR/tpl/deis-monitor-influxdb-svc* $HELM_GENERATE_DIR/manifests/
else
  rm -rf $HELM_GENERATE_DIR/manifests/deis-monitor-influxdb-*
fi

grafana_location=`grep "grafana_location\s*=\s*" $HELM_GENERATE_DIR/tpl/generate_params.toml | cut -d "=" -f2 | tr -dc '[:alnum:]-\n\r'`
if [ "$GRAFANA_LOCATION" = "on-cluster" ] || ( [ -z "$GRAFANA_LOCATION" ] && [ "$grafana_location" = "on-cluster" ] ); then
  helmc tpl -d $HELM_GENERATE_DIR/tpl/generate_params.toml -o $HELM_GENERATE_DIR/manifests/deis-monitor-grafana-deployment.yaml $HELM_GENERATE_DIR/tpl/deis-monitor-grafana-deployment.yaml
  cp $HELM_GENERATE_DIR/tpl/deis-monitor-grafana-svc* $HELM_GENERATE_DIR/manifests/
else
  rm -rf $HELM_GENERATE_DIR/manifests/deis-monitor-grafana-*
fi
