# Deis Chart Repository

[![Build Status](https://travis-ci.org/deis/charts.svg?branch=master)](https://travis-ci.org/deis/charts)

This repository contains Helm Classic Charts for Deis, the open source PaaS company. Deis (pronounced DAY-iss) Workflow is an open source Platform as a Service (PaaS) that adds a developer-friendly layer to any [Kubernetes][k8s-home] cluster, making it easy to deploy and manage applications on your own servers.

For more information about Deis Workflow, please visit the main project page at https://github.com/deis/workflow. For more general-purpose Helm Classic Charts, visit the [Helm Classic Chart repository](https://github.com/helm/charts). To learn more about Helm Classic, visit the [Helm Classic repository](https://github.com/helm/helm-classic).

## Beta Status

Many Deis components are currently in beta status, and we welcome your input! If you have feedback one one of the charts herein, please [submit an issue][issues]. If you'd like to participate in development, please read the "Development" section below and [submit a pull request][prs].

# Development

The Deis project welcomes contributions from all developers. The high level process for development matches many other open source projects. See below for an outline.

* Fork this repository
* Make your changes
* [Submit a pull request][prs] (PR) to this repository with your changes, and unit tests whenever possible
	* If your PR fixes any [issues][issues], make sure you write `Fixes #1234` in your PR description (where `#1234` is the number of the issue you're closing)
* The Deis core contributors will review your code. After each of them sign off on your code, they'll label your PR with `LGTM1` and `LGTM2` (respectively). Once that happens, a contributor will merge it

## Contributing

First, add this Chart repo to Helm Classic to install the current "workflow-dev" chart:

### Prerequisites

You must enable the extensions api for your kube-apiserver. For now the only requirement is that the daemonsets portion of the api be enabled. To do this add the following line to the script that starts your api server:

```console
--runtime-config=extensions/v1beta1=true,extensions/v1beta1/daemonsets=true
```

you can also do `ENABLE_DAEMONSETS=true` before running the `kube-up.sh` script.

### Installation

First, add this Chart repo to Helm Classic to install the "workflow" chart:

```console
$ helmc repo add deis https://github.com/deis/charts
$ helmc up
$ helmc fetch deis/workflow-dev
$ helmc generate workflow-dev  # creates the required secrets
$ helmc install workflow-dev
$ kubectl --namespace=deis get pods -w # watch this until all pods show "Running"
$ kubectl --namespace=deis get svc deis-router
# note the "EXTERNAL_IP" field for IP address on GKE/GCE/AWS, on Vagrant look for an "IP(S)"
```

Then install the `deis` client, register yourself as a user and create your first application:

```console
$ curl -sSL http://deis.io/deis-cli/install-v2.sh | bash
$ export PATH=.:$PATH
$ deis register deis.IP_YOU_GOT_ABOVE.xip.io  # register as the first user
$ ssh-keygen -t rsa -b 4096 -C "your_email@deis.com"
$ eval $(ssh-agent) && ssh-add ~/.ssh/id_rsa
$ deis keys:add ~/.ssh/id_rsa.pub
```

Now let's create an App:

```
$ git clone https://github.com/deis/example-go.git
$ cd example-go
$ deis create mytest
Creating Application... done, created madras-radiator
$ git push deis master
Creating build... ..o
$ deis open
$ deis scale web=3 -a mytest # to scale up the app
```

### Dockerfile for deis/charts e2e tests
```
<---SECRET FILE-->
The secret file is the Google Cloud credentials(helm-credentials.json)  which you will already have for the helm-project. If not found, you can download from the Google cloud platform ( API Manager -> Credentials ). NOTE: Get access to the
helm-project)

$ docker build .

To call init script
$ docker run -v YOUR VOLUME WITH SECRET FILE:/root/.secrets/ IMAGE_ID /bin/bash _scripts/tests/init.sh

To call install script
$ docker run -v YOUR VOLUME WITH SECRET FILE:/root/.secrets/ IMAGE_ID /bin/bash _scripts/tests/install.sh

To call uninstall script
$ docker run -v YOUR VOLUME WITH SECRET FILE:/root/.secrets/ IMAGE_ID /bin/bash _scripts/tests/uninstall.sh

To call destroy script
$ docker run -v YOUR VOLUME WITH SECRET FILE:/root/.secrets/ IMAGE_ID /bin/bash _scripts/tests/destroy.sh

To call test script
$ docker run -v YOUR VOLUME WITH SECRET FILE:/root/.secrets/ IMAGE_ID /bin/bash _scripts/tests/test.sh
```

## License

Copyright 2015, 2016 Engine Yard, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

[issues]: https://github.com/deis/charts/issues
[prs]: https://github.com/deis/charts/pulls
[k8s-home]: http://kubernetes.io
