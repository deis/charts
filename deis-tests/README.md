# Deis 2.0.0-beta Tests

End-to-end tests for the Deis v2 open source PaaS.

NOTE: This assumes a fresh `helm install` of Deis v2. The test suite creates
an initial user with admin privileges (who is deleted when tests complete).
See https://github.com/deis/workflow-e2e for more detail.

```console
$ helm uninstall -n deis -y deis-tests ; helm install deis-tests
$ kubectl --namespace=deis logs -f deis-tests
```
