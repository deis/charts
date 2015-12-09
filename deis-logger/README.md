# deis-logger
This chart will start a service and replication controller which is needed to fulfill requests to the logger component. The deis controller talks to logger over port 8080 and returns the logs to the deis cli. The logger component also listens on port 514 and accepts any syslog compatible message.

You must have daemonsets enabled for this chart to work. Read more about that [here](https://github.com/kubernetes/kubernetes/blob/master/docs/api.md#enabling-resources-in-the-extensions-group).
