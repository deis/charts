# deis-monitor
This chart provides several components that provide a complete monitoring and alerting stack for both deis and kubernetes. It uses InfluxDB as its time series database (TSDB), Telegraf for metrics collection of the host and containers, Grafana 2 for graphing and visualization, and Kapacitor for alerting.

If you would like to find out more about each individual component and how they are configure please visit https://github.com/deis/monitor

You must have daemonsets enabled for this chart to work. Read more about that [here](https://github.com/kubernetes/kubernetes/blob/master/docs/api.md#enabling-resources-in-the-extensions-group).
