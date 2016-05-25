# Workflow 2.0.0-rc1 e2e Tests (parallel)

End-to-end tests for the Deis Workflow open source PaaS, executed in parallel.

NOTE: This assumes a fresh `helmc install` of Deis v2. The test suite creates
an initial user with admin privileges (who is deleted when tests complete).
See https://github.com/deis/workflow-e2e for more detail.

```console
$ helmc uninstall -n deis -y workflow-rc1-e2e ; helmc install workflow-rc1-e2e
$ kubectl --namespace=deis logs -f workflow-rc1-e2e tests
```
