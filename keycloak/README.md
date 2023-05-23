<!--
SPDX-FileCopyrightText: 2023-present Intel Corporation

SPDX-License-Identifier: Apache-2.0
-->

# Keycloak Helm Chart configuration

[Keycloak] is Open Source Identity and Access Management for Modern Applications and
Services.

It can also act as a Federated [OpenID Connect] provider. It can connect to a variety of backends.
In this deployment it is not connected to a backend, and just uses its own internal format
persisted to a local Postgres DB.

This chart can be deployed alongside [aether-roc-umbrella](../aether-roc-umbrella) or any other umbrella
chart that requires an OpenID provider.

## Helm install
Add the Bitnami repo to `helm`, if you don't already have them:
```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

To install the standalone Keycloak server in to a namespace e.g. `aether` use:

```shell
helm -n aether install keycloak bitnami/keycloak -f keycloak/values.yaml
```

> See the end of this page for uninstall instructions.

This will make it available at http://localhost:80

Now GUI applications with security enabled will redirect to this `localhost:80`
and when login is successful will redirect to an authenticated GUI.

> To test it, browse to http://localhost/realms/master/.well-known/openid-configuration to see the configuration.

> On KinD installations this LoadBalancer will not work and instead a port-forward will be needed e.g.
>
> `kubectl -n aether port-forward service/keycloak 8080:80`
>
> and replace `localhost` in instructions below with `localhost:8080`


There are 7 users in 8 groups with the LDIF defined in `values.yaml`

```
User             login                 Group:   mixedGroup      charactersGroup    AetherROCAdmin  EnterpriseAdmin  starbucks   acme   defaultent   aiab-enterprise
===================================================================================================================================================================
Alice Admin      alicea@opennetworking.org         ✓                                   ✓
Bob Cratchit     bobc@opennetworking.org           ✓              ✓
Charlie Brown    charlieb@opennetworking.org                      ✓
Daisy Duke       daisyd@opennetworking.org                        ✓                                    ✓              ✓                                    ✓
Elmer Fudd       elmerf@opennetworking.org                        ✓                                                   ✓                                    ✓
Fred Flintstone  fredf@opennetworking.org                         ✓                                    ✓                          ✓        ✓
Gandalf The Grey gandalfg@opennetworking.org                      ✓                                                               ✓        ✓
```

The password for each is `password`

> Verify the login details at http://localhost/realms/master/account/

To use this service with `aether-roc-umbrella` chart, deploy in Helm with the following flags:
```
helm -n aether install aether-roc-umbrella aether/aether-roc-umbrella \
    --set onos-config.openpolicyagent.enabled=true \
    --set onos-config.openpolicyagent.regoConfigMap=aether-roc-umbrella-opa-rbac \
    --set onos-config.openidc.issuer=http://keycloak/realms/master \
    --set aether-roc-api.openidc.issuer=http://keycloak/realms/master \
    --set aether-roc-gui-v2-1.openidc.issuer=http://localhost/realms/master \
    --set prom-label-proxy-acc.config.openidc.issuer=http://keycloak/realms/master \
    --set prom-label-proxy-amp.config.openidc.issuer=http://keycloak/realms/master
```

> Note here that the connection to keycloak is inside the cluster for the backend services at `http://keycloak`
> whereas the GUI connects to `http://localhost`

## Administration
The Keycloak Admin console can be reached at http://localhost `admin/admin`

## Uninstall
To uninstall:
```shell
helm -n aether uninstall keycloak
kubectl -n aether delete pvc data-keycloak-postgresql-0
```

[Keycloak]: https://www.keycloak.org/
[OpenID Connect]: https://openid.net/connect/
