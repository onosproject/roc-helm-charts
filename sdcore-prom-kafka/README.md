<!--
SPDX-FileCopyrightText: 2022-present Intel Corporation
SPDX-FileCopyrightText: 2021 Open Networking Foundation

SPDX-License-Identifier: Apache-2.0
-->

## SD-Core Prometheus to Kafka

Provides a [Helm] chart for polling from [Prometheus] and pushing to [Kafka].

Note: Be sure to override the values for kafkaURI and prometheusEndpoint if they
differ for a production deployment.
