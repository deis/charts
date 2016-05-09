# Deis v2.0.0-beta1 Tests

End-to-end tests for the Deis v2 open source PaaS.

NOTE: This assumes a fresh `helmc install` of Deis v2. The test suite creates
an initial user with admin privileges (who is deleted when tests complete).
See https://github.com/deis/workflow-e2e for more detail.

```console
$ helmc install deis-workflow-beta1-e2e
$ kubectl --namespace=deis logs -f deis-workflow-beta1-e2e -c deis-e2e
```
