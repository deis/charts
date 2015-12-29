# Deis Chart Repository

[![Build Status](https://travis-ci.org/deis/charts.svg?branch=master)](https://travis-ci.org/deis/charts)

This repository contains Helm Charts for Deis v2, the open source PaaS.

For more general-purpose Helm Charts, visit the [Helm Chart repository](https://github.com/helm/charts). To learn more about Helm, visit the [Helm repository](https://github.com/helm/helm).

## Work in Progress

![Deis Graphic](https://s3-us-west-2.amazonaws.com/get-deis/deis-graphic-small.png)

Deis v2 and Helm are changing quickly. Your feedback and participation are more than welcome, but be aware that this project is considered a work in progress.

## Contributing

Hacking on Deis v2 is a bit rough right now--please help us fix the bugs and improve the installation process.

First, add this Chart repo to Helm to install the "deis" chart:
```console
$ helm repo add deis https://github.com/deis/charts
$ helm up
$ helm fetch deis/deis
$ helm install deis
$ kubectl get pods  # repeat this until deis-workflow is "Running"
$ kubectl get service deis-workflow  # note the IP address for later
```

Then open an SSH session to a Kubernetes minion node, install the `deis` client, and register:

```console
$ curl -sSL http://deis.io/deis-cli/install-v2-alpha.sh | bash
$ mkdir $HOME/bin && mv deis $HOME/bin
$ deis register 10.247.59.157:8000  # or the appropriate CLUSTER_IP, from above
$ ssh-keygen -t rsa -b 4096 -C "your_email@deis.com"
$ eval $(ssh-agent) && ssh-add ~/.ssh/id_rsa
$ deis keys:add ~/.ssh/id_rsa.pub
$ deis create --no-remote
Creating Application... done, created madras-radiator
$ deis pull deis/example-go -a madras-radiator
Creating build... ..o
```

## License

Copyright 2015 Engine Yard, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
