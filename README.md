# Deis Chart Repository

[![Build Status](https://travis-ci.org/deis/charts.svg?branch=master)](https://travis-ci.org/deis/charts)

This repository contains Helm Charts for Deis v2, the open source PaaS.

For more general-purpose Helm Charts, visit the [Helm Chart repository](https://github.com/helm/charts). To learn more about Helm, visit the [Helm repository](https://github.com/helm/helm).

## Work in Progress

![Deis Graphic](https://s3-us-west-2.amazonaws.com/get-deis/deis-graphic-small.png)

Deis v2 and Helm are changing quickly. Your feedback and participation are more than welcome, but be aware that this project is considered a work in progress.

## Contributing

First, add this Chart repo to Helm to install the current "deis-dev" chart:

```console
$ helm repo add deis https://github.com/deis/charts
$ helm up
$ helm fetch deis/deis-dev
$ helm generate deis-dev  # creates the required secrets
$ helm install deis-dev
$ kubectl --namespace=deis get pods -w # watch this until all pods show "Running"
$ kubectl --namespace=deis get svc deis-router  
# note the "EXTERNAL_IP" field for IP address on GKE/GCE/AWS, on Vagrant look for an "IP(S)"
```

Then install the `deis` client, register yourself as a user and create your first application:

```console
$ curl -sSL http://deis.io/deis-cli/install-v2-alpha.sh | bash
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

## License

Copyright 2015, 2016 Engine Yard, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at <http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
