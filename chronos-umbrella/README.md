<!--
SPDX-FileCopyrightText: 2021 Open Networking Foundation <info@opennetworking.org>

SPDX-License-Identifier: Apache-2.0
-->

## Chronos Umbrella chart

Provides a [Helm] chart for deploying

* aether-enterprise-portal
* chronos-exporter
* grafana
* prometheus

to [Kubernetes].
> See the [documentation] for more info.

### Deployment on own K8S
To deploy locally use
```bash
helm -n chronos install chronos-umbrella aether/chronos-umbrella
```

and port-forward with:
```bash
kubectl -n chronos port-forward deployment/aether-enterprise-portal 8184:80
```

### Deployment on https://chronos-dev.onlab.us

When deployed this is available as

* aether-enterprise-portal: https://chronos-dev.onlab.us
* chronos-exporter config: https://chronos-dev.onlab.us/chronos-exporter/config
* prometheus config: https://chronos-dev.onlab.us/prometheus/graph
* grafana: https://chronos-dev.onlab.us/grafana

> This is protected with basic Auth: username `onfstaff` - ask for password

To update the deployment for a new version of `chronos-umbrella` update the 2 files:

* https://gerrit.opencord.org/c/aether-app-configs/+/29774/1/aether-dev/app/chronos/values.yaml
* https://gerrit.opencord.org/c/aether-app-configs/+/29774/1/aether-dev/app/chronos/fleet.yaml

> if your patch changes the configmap only, we have to delete the pod to reload the cnofigmap

[Kubernetes]: https://kubernetes.io/
[Helm]: https://helm.sh/
[documentation]: https://docs.onosproject.org/developers/deploy_with_helm/
