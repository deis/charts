### v2.0.0-beta1 -> v2.0.0-beta2

#### Features

 - [`1423833`](https://github.com/deis/controller/commit/1423833133b74d6d1dd79d493fc3bf57307d4143) logger: Add logger to the workflow-dev chart
 - [`c9e046c`](https://github.com/deis/controller/commit/c9e046c58720fcf83d1ac8890281d90176c9614f) storage: remove the minio user secret
 - [`ba8bf12`](https://github.com/deis/controller/commit/ba8bf1203237efa7c25867c641512cd486eb3cb4) storage: add details for the builder and database buckets
 - [`6634014`](https://github.com/deis/controller/commit/66340142a5830aa5e370ebe50f33594ed7d6f34c) settings: use k8s 1.2 secrets as env vars to configure production settings
 - [`23fa913`](https://github.com/deis/controller/commit/23fa913b7a97b429f592cc2ae35dcad78155b116) workflow_test.groovy: archive (log
 - [`e6af3de`](https://github.com/deis/controller/commit/e6af3defd7914b594ab1ea9c9ad87d2c9f9d5eed) jobs: add workflow-test job DSL
 - [`4e962f1`](https://github.com/deis/controller/commit/4e962f18905f436ff477e8dd2978366355ddd1d2) jenkins: migrate various <component>-master jobs and deis-v2-e2e(-master/-pr

#### Fixes

 - [`99937b5`](https://github.com/deis/controller/commit/99937b55cda6e49991b692f31102f779b717e227) e2e: name the e2e pod manifest generically
 - [`23d755f`](https://github.com/deis/controller/commit/23d755f67ca7abfcc69f31d6e89702c37d0eedd6) (all): Jenkins sets SUDO_USER which messes with rerun behavior now
 - [`b20c66d`](https://github.com/deis/controller/commit/b20c66d60bda40696247b62c93542b6ef96bedd8) chart: workflow-manager image should be :canary
 - [`c423d5c`](https://github.com/deis/controller/commit/c423d5ce087f9430c684b68d88609233d656dfd2) component_jobs.groovy: adjust workflow-manager logic
 - [`407fc61`](https://github.com/deis/controller/commit/407fc613a6a5784c6f1399c49118e89310402d9d) component_jobs.groovy: remove extra brace that snuck in with last PR
 - [`a4d45ec`](https://github.com/deis/controller/commit/a4d45ec48e8479421015a68d3565d7fb34682cb1) jobs: remove common.groovy until needed
 - [`23aab6b`](https://github.com/deis/controller/commit/23aab6bccd0bf7c6c81ba8e82efd7efa19c6c8b3) component_jobs.groovy: remove extraneous curly brace

#### Maintenance

 - [`20b4d38`](https://github.com/deis/controller/commit/20b4d38bd735e538908c55f349395e29d3ebbccf) release: add beta2 charts for workflow and workflow-e2e
 - [`d24d864`](https://github.com/deis/controller/commit/d24d86480befdec1767fe392a90eaf468c45802f) deis-tests-parallel: Back down the number of concurrent test processes
 - [`09a27c5`](https://github.com/deis/controller/commit/09a27c576e583b26e146dbcf26a6c82670143fd3) deis-test: Reset deis-test pod back to normal
 - [`6d9e6aa`](https://github.com/deis/controller/commit/6d9e6aa6c93940e3bf0630150776b797b5974548) deis-tests: Wrong chart was updated for number of parallel nodes
 - [`6e10748`](https://github.com/deis/controller/commit/6e1074872e2cba9d0bc97a4df1b23ee5c38e5fe8) deis-tests: Update timeouts to reflect parallel test run reqs
 - [`9dec49b`](https://github.com/deis/controller/commit/9dec49b25a477fb35cf9a0b74fd68ab27f26dc76) deis-tests: Use 15 parallel nodes instead of 30
 - [`8932f5d`](https://github.com/deis/controller/commit/8932f5d7d46f6f78010ff319d0a1037fc0f27cd6) deis-tests: Make the deis-tests run in parallel by default
 - [`5c575a2`](https://github.com/deis/controller/commit/5c575a24d6583586958b5992668fefd886b6dec1) jobs: remove jobs as they now live in deis/jenkins-jobs
