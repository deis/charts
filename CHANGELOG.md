### v2.0.0-rc1 -> v2.0.0-rc2

#### Features

- [`de38946`](https://github.com/deis/charts/commit/de38946c353d9a70fab093523dd96e70feebd20e) router: Make platformDomain configurable thru toml
- [`4295812`](https://github.com/deis/charts/commit/429581228e26273623e4ff6770027dcbbe83bca2) builder: add git push lock timeout env to builder rc

#### Fixes

- [`dee1f1e`](https://github.com/deis/charts/commit/dee1f1e3167f04c4f544621cd928ff159f0dca28) router-dev: Better parity with workflow-dev chart

#### Maintenance

- [`63ea94e`](https://github.com/deis/charts/commit/63ea94ecb1dbd636ef7f1de6d7567114fe2c00bf) controller: Add grafana as a reserved name
- [`be9c5eb`](https://github.com/deis/charts/commit/be9c5ebd5186da2fc94ac15631ac48a015cb50dd) workflow-rc2: releasing workflow-rc2(-e2e) and router-rc2

### v2.0.0-beta4 -> v2.0.0-rc1

#### Features

 - [`137ba7d`](https://github.com/deis/charts/commit/137ba7d0ea5e8d7f38ea93e41a08f4bb24315eb3) workflow-dev: annotate "keeper" manifests
 - [`20c052d`](https://github.com/deis/charts/commit/20c052dbebd05f08683df7a9afee8e0a70a26854) tpl: template object-store-creds to take environment variables
 - [`bd67a43`](https://github.com/deis/charts/commit/bd67a43fb406aa17b2d80b2a0a9249c3abf6a36e) minio: install minio only if the storage type is minio
 - [`3be31cf`](https://github.com/deis/charts/commit/3be31cfa9b0433c415f66c705edf50335c9a05e8) monitor: Add a chart that starts the deis monitoring stack
 - [`2d6ec15`](https://github.com/deis/charts/commit/2d6ec15d8638ce8bf0948ee5e408878ee0f6b00d) deis-builder-rc: get DEBUG from env or set to false
 - [`642ac14`](https://github.com/deis/charts/commit/642ac1499c00525868cec4bf85a4daa83c6667ee) workflow-manager-rc: pull versionsApiURL from generate_params.toml

#### Fixes

 - [`2bad9e5`](https://github.com/deis/charts/commit/2bad9e5cf6dd00246aabd5ccd5b1cc139e89945c) templates: adjust templates options accordingly
 - [`3292359`](https://github.com/deis/charts/commit/3292359e475dbb7759af17f965b2d15b88d4ea93) minio: use the helm classic instead of helm to run template
 - [`b651824`](https://github.com/deis/charts/commit/b651824497380f0690c643ddd8f349f99bb7f108) controller: change the readiness probe endpoint

#### Documentation

 - [`8e30743`](https://github.com/deis/charts/commit/8e307435d1b9e80912e02f8c03be4d5d55968246) workflow-dev chart: update README
 - [`8ae5437`](https://github.com/deis/charts/commit/8ae54378c60533b405f32d88cb079f398959cb91) (all): Update docs and comments for helm classic
 - [`7d2e512`](https://github.com/deis/charts/commit/7d2e512ed79559975bf3c0ab538945584911eb86) README: update with logger repo url

#### Maintenance

 - [`8b1590a`](https://github.com/deis/charts/commit/8b1590aa1059d054e8a7fcfb2d3e675386b099e1) workflow-rc1: releasing workflow-rc1(-e2e
 - [`f2f962e`](https://github.com/deis/charts/commit/f2f962e94461a97aa4b758990d4a362470b9863e) ci: Download chart-mate from deis bintray
 - [`abb6feb`](https://github.com/deis/charts/commit/abb6febb25a452bcdfef36de211cbb9f96726c82) workflow-beta4: releasing workflow-beta4(-e2e
 - [`24493c2`](https://github.com/deis/charts/commit/24493c23d44bcb493ff80e6634606a7d470e9fb3) Dockerfile: Remove unnecessary Dockerfile
 - [`52c5e58`](https://github.com/deis/charts/commit/52c5e58085f3ad8a0c9c2c26da54d52cea17774d) controller: Add default RESERVED_NAMES to chart

### v2.0.0-beta2 -> v2.0.0-beta3

#### Features

 - [`d2e2dc7`](https://github.com/deis/charts/commit/d2e2dc787a9ea059ccde79d82d2613d436e8582b) workflow-dev-e2e: use GINKGO_NODES from local env if exists
 - [`6309f5c`](https://github.com/deis/charts/commit/6309f5c944ef17741b03c3b76d23b25d97640f07) workflow-dev: store builder ssh private keys in secret
 - [`2eb4750`](https://github.com/deis/charts/commit/2eb475059e8a88269d6aba67a355ff3db824dd78) (all): replace values that change with each release with template values
 - [`c0bad28`](https://github.com/deis/charts/commit/c0bad282ea11da388f18473d0f77e3147d47418f) ci.sh: add uninstall step in teardown
 - [`c3ffd5a`](https://github.com/deis/charts/commit/c3ffd5aca086321d136bba4406e11d6da57e7644) _scripts: add CHANGELOG.md and generator script

#### Fixes

 - [`eaf9ebc`](https://github.com/deis/charts/commit/eaf9ebcd29383336466b71dbcb35e791e908899a) fluentd: Remove privileged:true from manifest
 - [`77955b6`](https://github.com/deis/charts/commit/77955b654f3d347f193e565b66ebbde34d019b0b) workflow-dev: fixup incorrect usage of helm tpl
 - [`f2beeb4`](https://github.com/deis/charts/commit/f2beeb406888759d91c9eb49950a8f8995c70a7d) workflow-dev-e2e: Missed quoting the env var for fetch the git sha

#### Maintenance

 - [`0d09e83`](https://github.com/deis/charts/commit/0d09e831cda2f3c6376a82b95028c20b4a6122e5) workflow-beta3: releasing workflow-beta3
 - [`e6a8996`](https://github.com/deis/charts/commit/e6a8996d9205478fc6d0e1b66b74a6d5e70ad231) objectstorage: filesystem is not a supported object storage type

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

### v2.0.0-beta1

#### Features

 - [`c71fd05`](https://github.com/deis/charts/commit/c71fd0518bf4655eeb319286831d86e72747a9ba) deis-tests: mount /tmp emptyDir for storing artifacts
 - [`48bbf71`](https://github.com/deis/charts/commit/48bbf71e9f8d439bfdf713c66f04c6eb315e7e3e) Makefile/ci.sh: use bumpver, simplify calls to chart-mate
 - [`e4c0172`](https://github.com/deis/charts/commit/e4c0172bd4dd88a42c04306dc6474337dc210e14) deis-tests: enable junit test reporting
 - [`3f2b185`](https://github.com/deis/charts/commit/3f2b185d77c82847a953ca3c12168e6c8a5595e9) mutable: change slugrunner,slugbuilder image setting to point canary
 - [`9bbdbfa`](https://github.com/deis/charts/commit/9bbdbfa2ba75faa59d59004bf5c48044846cc38c) workflow-manager: added workflow-manager to deis-dev manifests
 - [`7373b46`](https://github.com/deis/charts/commit/7373b46444e00d2f6f665f61c1457d4c180aae71) builder: get the slug/docker builder images from the environment
 - [`3b299d5`](https://github.com/deis/charts/commit/3b299d5fa2510e03e4fa474ac6188bb97dbd416a) dockerfile: Added Dockerfile for deis chart e2e test.
 - [`238b6f6`](https://github.com/deis/charts/commit/238b6f684c80f030dd69f30a3ed950a60edd0903) fix: move builder and workflow rc to tpl direcotry
 - [`6651fef`](https://github.com/deis/charts/commit/6651fefd4baa9bf333b9c6de030255e086a5969c) storage: add storage envs to builder and workflow rcs
 - [`abb282e`](https://github.com/deis/charts/commit/abb282e42e3c26e74110a0fcd9845adcef824c1d) postgres: use object storage tempaltes
 - [`1b71b8a`](https://github.com/deis/charts/commit/1b71b8acf64334c471878c55e9509b716d9060eb) registry: add object storage templates
 - [`d6469ce`](https://github.com/deis/charts/commit/d6469ced90c650f3ed152972ff3959fd74b43fc4) tests: move most of the infrastructure provisioning to chart-mate
 - [`84bf578`](https://github.com/deis/charts/commit/84bf578988d9e96e6f96e5b08293eefd528fb66f) _scripts: check deis platform url multiple times
 - [`2526ca8`](https://github.com/deis/charts/commit/2526ca840fdd1faf9daabc17b0bd30fd67661dc5) _scripts: use git sha of e2e test docker image instead of canary
 - [`f813c40`](https://github.com/deis/charts/commit/f813c40526f98aab1adddb9b0a6122a5e72c08b2) _scripts: improve version bumper script
 - [`bd7119f`](https://github.com/deis/charts/commit/bd7119f0d5ad67ffe46f8bba32bb607279266fbc) _scripts: add version bumper for ci
 - [`c138f2b`](https://github.com/deis/charts/commit/c138f2bc77763af0d8ea8b0097ec3f3a2bbb1a3c) deis-dev: use randAlphaNum
 - [`d6a746e`](https://github.com/deis/charts/commit/d6a746e82b37393e8b5c359c532c123745e559f6) deis-dev: add username/password secret
 - [`8ba25bf`](https://github.com/deis/charts/commit/8ba25bf7c6c22dd9c12922907ae961f64cdd9ae0) deis-dev/manifests/deis-builder-rc.yaml: add liveness and readiness probes
 - [`a1cede7`](https://github.com/deis/charts/commit/a1cede7a52bda5b5885317778c9cd30540077c11) deis-dev: mount minio secrets into deis-database
 - [`6de0b85`](https://github.com/deis/charts/commit/6de0b851b4fb018b63667839d982a29f2bbf05b2) deis-dev: add postgres livenessProbe
 - [`a0f2b9b`](https://github.com/deis/charts/commit/a0f2b9b14c8fb7026d759dbcb1dadca440b29430) tests: improve error handling and use one loop function for all pod interactions
 - [`20d4e4e`](https://github.com/deis/charts/commit/20d4e4e850cb60ee69470c9281d9a439457b758b) deis-tests: always pull updated test image
 - [`af6fd89`](https://github.com/deis/charts/commit/af6fd89b1cc8f2ec14e3f39408983fecb01812ad) tests: add e2e test running in gke
 - [`a88df5d`](https://github.com/deis/charts/commit/a88df5db5c631b24eb0b83aa6b153997052515af) deis-tests: add e2e test chart
 - [`16a6a2d`](https://github.com/deis/charts/commit/16a6a2d3652ea8e747b52ae7b16c933d50bac1cb) logger: - adding logger support to the chart
 - [`99a21bd`](https://github.com/deis/charts/commit/99a21bd5f87b3b485ad427ea7ac239d1e1a1d214) router: Add secret bearing dhparam for router
 - [`ff7b359`](https://github.com/deis/charts/commit/ff7b359333d5afe3ea488e6fd3b95f7a8115934e) workflow: generate secrets for builder and django
 - [`50a291c`](https://github.com/deis/charts/commit/50a291c5cf6754c4b1b31f6bcc2a8150b1cc2f42) registry: add k8s readiness and liveness probes
 - [`98293c3`](https://github.com/deis/charts/commit/98293c35d2965cf45a4269a80d713fbf62551f22) router: add standalone charts for router and router-dev
 - [`9c0f390`](https://github.com/deis/charts/commit/9c0f3905318a11bf807e7aa8a5121f905f16e3ea) manifests: etcd - move volumes part, just to have a consistency…
 - [`a78df9c`](https://github.com/deis/charts/commit/a78df9c6befd5eee63d9d036d56fcd2d0b819846) router: add service for router
 - [`73583c3`](https://github.com/deis/charts/commit/73583c3c79410f407e68f3b4c8fa3e1f26630aa5) router: add support for non-proxy-proto healthz
 - [`f2dac9a`](https://github.com/deis/charts/commit/f2dac9a8c25a6344192a6c376c1d078b4b55c83d) workflow: make workflow routable
 - [`b7c5237`](https://github.com/deis/charts/commit/b7c52373e0b3e109a4cc2858e7664a71051bbc76) etcd: use downward API for namespaces
 - [`4b65923`](https://github.com/deis/charts/commit/4b6592345ab88daea04e1d7d12f14b716706b4cf) manifests: add router manifest
 - [`7668cbf`](https://github.com/deis/charts/commit/7668cbf48a2e1ea0990b9946e1ddc4fef672b0e3) README.md: add hacking instructions

#### Fixes

 - [`ef47ffb`](https://github.com/deis/charts/commit/ef47ffb12058e5d4b5f4cedac5cde126fda86353) builder: disable DEBUG level in builder
 - [`a5d6e67`](https://github.com/deis/charts/commit/a5d6e67551a0d637f07ff2d7695ea8ac46b4e0d1) (all): remove duplicate init call
 - [`de8b45e`](https://github.com/deis/charts/commit/de8b45e2b775d2b98b690050a5a042cf05550fd5) beta1/minio: Fix image pull policy to IfNotPresent
 - [`cd396ae`](https://github.com/deis/charts/commit/cd396ae4d6bff24c8bf83bf7e20e0c1651d30a9f) router-dev: Fix metadata issue preventing install
 - [`2a84e44`](https://github.com/deis/charts/commit/2a84e4459ca5433ba5fa179f543c59252ecfdd46) charts: fixup workflow-beta1-test chart name
 - [`8619202`](https://github.com/deis/charts/commit/861920226063dd6911b7093663b595562e72d791) registry:  use the canary tag
 - [`83fd231`](https://github.com/deis/charts/commit/83fd231405ab37e4dc4f2f2db37b79801e27c03c) deis-dev: use canary instead of v2-beta where it makes sense
 - [`87778b5`](https://github.com/deis/charts/commit/87778b5f5c13963df556cda394d64780285893d8) deis-dev: change controller tag
 - [`b30f59f`](https://github.com/deis/charts/commit/b30f59fe29d6bd40ddfea64950c6f2810c1e2ebd) quay: now with a working image!
 - [`9116831`](https://github.com/deis/charts/commit/9116831ea745c850abe49a8ff2080619bff1191c) deis-dev/manifests/deis-registry-service.yaml: make the registry service listen on port 80
 - [`9262e3d`](https://github.com/deis/charts/commit/9262e3dafeaf1616737e359bd08d129b00ce3f71) deis-dev: use minio as the default storage
 - [`f164079`](https://github.com/deis/charts/commit/f1640796e6fbc7e1268002633933667cbbacc2f2) deis-logger/manifests/deis-logger-svc.yaml: make the logger service run on port 80
 - [`a8931ad`](https://github.com/deis/charts/commit/a8931ad3715d896fc1001ca2b3c4b3b4457fea7d) deis-dev/manifests/deis-database-service.yaml: rename the postgres port appropriately
 - [`a8504a0`](https://github.com/deis/charts/commit/a8504a08f2580caa19c1ae14f9b838832b130c1e) logger: Add readiness and liveness probes
 - [`c75c6d3`](https://github.com/deis/charts/commit/c75c6d37441353a9f10d5c01cec8248885dedf8e) deis-tests: use canary tag for image
 - [`dc72b44`](https://github.com/deis/charts/commit/dc72b44847637f6f1b6ed026a158ed54c9444894) deis-dev: change database liveness probe to readiness
 - [`9e15dd3`](https://github.com/deis/charts/commit/9e15dd3fdcb1a07884c5f97cd661d257b174e521) object_store_template: use '_' instead of '-' for the key names …
 - [`df09042`](https://github.com/deis/charts/commit/df0904253aa9dd789a052b920dad24b7876667c8) deis-dev: triple-single-quote JSON value for toml
 - [`6a9cc73`](https://github.com/deis/charts/commit/6a9cc73997bea3ddff557f0d70fbd23f5e570f02) deis-dev/workflow: increase timeouts for readiness/liveness probes
 - [`8f31cdd`](https://github.com/deis/charts/commit/8f31cdd9645ce6845a876e81c4b69714084d1ac5) test: remove download-jq
 - [`7900fae`](https://github.com/deis/charts/commit/7900fae1c17e058d2d7a42cec4e07255568416a2) fluentd: Remove cpu limits from fluentd
 - [`4f63379`](https://github.com/deis/charts/commit/4f6337945fdf18132ac22ea8a1968fe63036b6c7) chart-version-bumper: remove space after -i on sed
 - [`4f5e864`](https://github.com/deis/charts/commit/4f5e864c8bcf2ff6be7ce4e86e9a182eb801e71f) logger: Only use unprivileged ports
 - [`8025eb8`](https://github.com/deis/charts/commit/8025eb8059aa07727746f5b1a4555de5c0cced5d) router: Fix incorrect host port mappings
 - [`d83f43e`](https://github.com/deis/charts/commit/d83f43e947e88d460ba6d8ae13b43d7fba9cacee) router: Use unprivileged target ports
 - [`3865bca`](https://github.com/deis/charts/commit/3865bca16366e7f8d8703fab12d038dc69ae1b1b) deis-dev: do not use random ascii code for username/password
 - [`9959924`](https://github.com/deis/charts/commit/99599243d407438916e51afdeb64902d65a042af) deis-dev: hotfix chart syntax
 - [`655039c`](https://github.com/deis/charts/commit/655039ce30e6cca6f422e0c270747851624b3ef6) router: Drop PROXY protocol option
 - [`42e13bb`](https://github.com/deis/charts/commit/42e13bb15ad4720ed189ddc35a8877d4b84a9934) deis-dev/manifests/deis-minio-rc.yaml: add probes to the minio RC
 - [`d441e42`](https://github.com/deis/charts/commit/d441e42901274f2486b9af6ec16995fc0f1d6f21) deis-builder-rc.yaml: add debug to the env for deis-dev builders
 - [`a3f734b`](https://github.com/deis/charts/commit/a3f734b00b05ba4c66f38c7b2c08d6c4b33bbd72) deis-builder-rc.yaml: remove DOCKERIMAGE env var"
 - [`20efeec`](https://github.com/deis/charts/commit/20efeecf8ca5280a4ca8875cccb3227ab0530dc8) deis-builder-rc.yaml: remove DOCKERIMAGE env var
 - [`47b9f77`](https://github.com/deis/charts/commit/47b9f778481bcd7808c4bdf2b8422278ac6a32f2) (all): use standard app labels & selectors, add heritage label where necessary [WIP]
 - [`1866922`](https://github.com/deis/charts/commit/1866922396dd38fdc03be82e1ffe631299094154) router: add service account needed by router
 - [`74a4834`](https://github.com/deis/charts/commit/74a483456a137507cc0d8f3b906aa9823986b663) readme: update deis v2 install part
 - [`9e9af51`](https://github.com/deis/charts/commit/9e9af51d7f78745f4e200af067133b1eec687d5a) readme: add deis namespace to kubectl commands
 - [`f03f5f4`](https://github.com/deis/charts/commit/f03f5f4e1179381c1c4e726e6185a9c750400521) docs: update the client url to the alpha client
 - [`6aee840`](https://github.com/deis/charts/commit/6aee8403c739cfcf6bd3f75a55b134c13a11d9ef) deis-workflow-rc.yaml: including & mounting minio creds
 - [`a0ba863`](https://github.com/deis/charts/commit/a0ba86398a7e83d14a69f548fca0d24051081b44) deis-builder-rc.yaml: tell the RC what namespace it's in
 - [`be63cd4`](https://github.com/deis/charts/commit/be63cd4e10a0ef17e5446b7dd129221930edcd59) deis-builder-rc.yaml: pass env var to make the minio client work…
 - [`b7bbf27`](https://github.com/deis/charts/commit/b7bbf275696b45dcb78f7acd1a7e1b13ab6f71d3) deis-builder-rc.yaml: add and mount secret for minio
 - [`468c0ca`](https://github.com/deis/charts/commit/468c0caa58d86de490b27d169920450c377bba3a) deis-builder-service.yaml: add target port for the builder RC
 - [`92d9372`](https://github.com/deis/charts/commit/92d93727fd98cf2ce505660659b45b17ef3aa94a) deis-builder-service.yaml: change selector to name
 - [`c5b3026`](https://github.com/deis/charts/commit/c5b30264098568dea6b76d7c74464b543cf3aac7) minio: use deisci/minio:v2-alpha image
 - [`229cf8d`](https://github.com/deis/charts/commit/229cf8d55e2b035c8ea311334ec0cb9ca0179b54) deis: remove redundant TCP protocol
 - [`2bc8110`](https://github.com/deis/charts/commit/2bc81100dbc87ea50c8a0b50393cd385f2c6d0e0) deis: remove redundant targetPort
 - [`2f6e3bb`](https://github.com/deis/charts/commit/2f6e3bb137293f0a7017f85b012a818b630a8040) deis: use official database repo

#### Documentation

 - [`e247886`](https://github.com/deis/charts/commit/e247886098fe42093a1c78984b70de37714cdafd) readme: added reference to workflow manager
 - [`519ef4e`](https://github.com/deis/charts/commit/519ef4e0d12d7dbd9244138e365f7a700c407c57) README.md: use deis-dev chart

#### Maintenance

 - [`bdc3e3f`](https://github.com/deis/charts/commit/bdc3e3f1c14edc0369bee9994d74d4d1587b4c5f) release: create beta1 charts
 - [`f7746ba`](https://github.com/deis/charts/commit/f7746ba564a4cb74de1907062c7a9e60e7e2977e) router: Cleanup standalone router charts
 - [`10d09b2`](https://github.com/deis/charts/commit/10d09b2e25d7e7b5264093a2fb5ca9fd553c8584) logger: Add beta1 chart for logger
 - [`8f25a43`](https://github.com/deis/charts/commit/8f25a43a124ba1f93f07d0b9e3244b3162e51322) controller-rc: update controller-rc with latest beta-approved tag
 - [`4a642e4`](https://github.com/deis/charts/commit/4a642e4dccf8c183f81371cb6ac9fd9e31ab78ee) workflow-beta1-test: create chart with immutable git shas
 - [`ea6c3f4`](https://github.com/deis/charts/commit/ea6c3f4b61ce00236466abdc5bf47e697d457dc4) workflow: remove workflow chart
 - [`c2672f4`](https://github.com/deis/charts/commit/c2672f4bc5fcc515a7b1722dd6f0b00f1f6e05b4) database: Transition to canary build where it makes sense
 - [`2e3cf7b`](https://github.com/deis/charts/commit/2e3cf7b3485dc428734508d1bc17cb7d52d9361e) router: Transition to canary images where it makes sense
 - [`b671ac8`](https://github.com/deis/charts/commit/b671ac86dfb2f6d5cc97e18ea919fb8dfac343ed) deis-tests: sync command-line e2e options
 - [`03c6591`](https://github.com/deis/charts/commit/03c6591af8ad081f956a0c95123f0db2593d9394) versions: use immutable tag version for workflow
 - [`4db45fb`](https://github.com/deis/charts/commit/4db45fb4c9502f951077382b3abc81479fa0d30f) deis-dev: remove database envvars
 - [`ff1e299`](https://github.com/deis/charts/commit/ff1e299b5af494f9cbdf98c1e8892047917e188d) router: Stop using JSON for router configuration
 - [`bbb6aa6`](https://github.com/deis/charts/commit/bbb6aa6af50d6a663ab8dace3412da82c9c9ed09) release: set image pull policy and point at deis registry repos
 - [`19ad3c0`](https://github.com/deis/charts/commit/19ad3c07fb3bd10b7cb5ce008c198ea3738efcc6) workflow: tweak workflow router config to match v1.x
 - [`1fc43cb`](https://github.com/deis/charts/commit/1fc43cb6f63e343b64d961dd43fddcdaefa6a82d) router: use downward api to get namespace
 - [`9abf071`](https://github.com/deis/charts/commit/9abf071e2c796e27523668d8fa1479109bb9a587) router: switch to using .io in annotation prefixes
 - [`050d201`](https://github.com/deis/charts/commit/050d201686b08f8d7326b832aee549c1c87eb585) router: prefix annotations with deis.com/
 - [`6fa293c`](https://github.com/deis/charts/commit/6fa293c1f0bed3ab8b756a6f469b048f9130f16c) deis: use deis namespace for all manifests
 - [`65e3c7e`](https://github.com/deis/charts/commit/65e3c7eaa6babf2dafeae2ee401fc4da06c69dbb) manifests: use imagePullPolicy: Always
