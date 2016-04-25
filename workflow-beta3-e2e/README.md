# Workflow 2.0.0-beta3 e2e Tests (parallel)

End-to-end tests for the Deis Workflow open source PaaS, executed in parallel.

NOTE: This assumes a fresh `helm install` of Deis v2. The test suite creates
an initial user with admin privileges (who is deleted when tests complete).
See https://github.com/deis/workflow-e2e for more detail.

```console
$ helm uninstall -n deis -y workflow-beta3-e2e ; helm install workflow-beta3-e2e
$ kubectl --namespace=deis logs -f workflow-beta3-e2e tests
```
