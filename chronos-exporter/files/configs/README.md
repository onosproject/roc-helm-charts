<!--
SPDX-FileCopyrightText: 2021 Open Networking Foundation <info@opennetworking.org>

SPDX-License-Identifier: Apache-2.0
-->

# Configuration

This YAML file must be valid compared to the OpenAPI3 specification at
https://github.com/onosproject/chronos-exporter/blob/master/api/config-openapi3.yaml

When the file is loaded in to the `chronos-exporter` it is unmarshalled in
to Go structs and then made available in JSON format at

```bash
curl http://localhost:2112/config
```

In a deployed `chronos-umbrella` this is available
through a reverse proxy at 

http://localhost:8184/chronos-exporter/config
