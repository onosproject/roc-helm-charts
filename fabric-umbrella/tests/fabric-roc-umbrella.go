// SPDX-FileCopyrightText: 2022-present Intel Corporation
//
// SPDX-License-Identifier: Apache-2.0

package tests

import (
	"testing"
	"time"

	"github.com/onosproject/helmit/pkg/helm"
	"github.com/onosproject/helmit/pkg/input"
	"github.com/onosproject/helmit/pkg/test"
	"github.com/stretchr/testify/assert"
)

const aetherCharts = "https://charts.aetherproject.org/"

// FabricUmbrellaSuite is the fabric-umbrella chart test suite
type FabricUmbrellaSuite struct {
	test.Suite
	c *input.Context
}

// SetupTestSuite sets up the fabric-umbrella test suite
func (s *FabricUmbrellaSuite) SetupTestSuite(c *input.Context) error {
	s.c = c
	return nil
}

// TestInstall tests installing the fabric-umbrella chart
func (s *FabricUmbrellaSuite) TestInstall(t *testing.T) {
	registry := s.c.GetArg("registry").String("")

	onos := helm.Chart("fabric-umbrella", aetherCharts).
		Release("fabric-umbrella").
		WithTimeout(15*time.Minute).
		Set("import.fabric-roc-gui.v0-1.enabled", false).
		Set("import.fabric-adapter.v0-1.enabled", false).
		Set("import.onos-cli.enabled", false).
		Set("import.prometheus.fabric.enabled", false).
		Set("fabric-roc-gui.service.type", "NodePort").
		Set("global.image.registry", registry)
	assert.NoError(t, onos.Install(true))
}
