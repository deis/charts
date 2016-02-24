# deis-workflow-manager

This chart manages the deis-workflow-manager Deis component. Exposes a service
listening port on TCP 8443, and a matching listening port on the RC container.

Deis Workflow Manager is a single pod (RC=1) application that assumes a proximate
deis cluster, and can gather, rationalize, and report usage data about it.
