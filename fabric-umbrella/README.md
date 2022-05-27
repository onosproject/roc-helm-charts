<!--
SPDX-FileCopyrightText: 2022-present Intel Corporation

SPDX-License-Identifier: Apache-2.0
-->

## Fabric ROC Umbrella chart

First add repos to your Helm client
```
stable       	https://charts.helm.sh/stable
cord         	https://charts.opencord.org
atomix       	https://charts.atomix.io
onosproject  	https://charts.onosproject.org
aether       	https://charts.aetherproject.org
cetic        	https://cetic.github.io/helm-charts
bitnami      	https://charts.bitnami.com/bitnami
```

Provides a [Helm] chart for deploying

* fabric-roc-gui (2 versions)
* fabric-roc-api 
* onos-topo
* onos-config
* fabric-adapter (2 versions)
* fabric-test-dummy
* prometheus

to [Kubernetes].
> See the [documentation] for more info.

## Config models
The Fabric ROC Umbrella chart controls the Config Model Plugins that are enabled in `onos-config`
Currently 2 versions of the `Aether` model are loaded:

* fabric-0.1.x

[Kubernetes]: https://kubernetes.io/
[Helm]: https://helm.sh/
[documentation]: https://docs.onosproject.org/developers/deploy_with_helm/
