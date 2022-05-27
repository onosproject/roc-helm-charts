// SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
//
// SPDX-License-Identifier: Apache-2.0

package main

import (
	"github.com/onosproject/helmit/pkg/registry"
	"github.com/onosproject/helmit/pkg/test"
	aether "github.com/opencord/roc-helm-charts/aether-roc-umbrella/tests"
	fabric "github.com/opencord/roc-helm-charts/fabric-umbrella/tests"
	_ "k8s.io/client-go/plugin/pkg/client/auth/gcp"
)

func main() {
	registry.RegisterTestSuite("aether-roc-umbrella", &aether.AetherRocUmbrellaSuite{})
	registry.RegisterTestSuite("fabric-umbrella", &fabric.FabricUmbrellaSuite{})
	test.Main()
}
