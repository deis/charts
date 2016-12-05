# Workflow v2.9.0 e2e Tests (parallel)

End-to-end tests for the Deis Workflow open source PaaS, executed in parallel.

NOTE: Kubernetes Helm has replaced Helm classic, so these charts are deprecated.
Workflow v2.9.0 will be the last release installable with Helm classic (helmc).
See https://github.com/deis/workflow-migration#workflow-migration for help upgrading
to Kubernetes Helm, and see https://deis.com/docs/workflow/installing-workflow/ for
general installation instructions.

NOTE: This assumes a fresh `helmc install` of Deis v2. The test suite creates
an initial user with admin privileges (who is deleted when tests complete).
See https://github.com/deis/workflow-e2e for more detail.

```console
$ helmc uninstall -n deis -y workflow-v2.9.0-e2e ; helmc install workflow-v2.9.0-e2e
$ kubectl --namespace=deis logs -f workflow-v2.9.0-e2e tests
```
