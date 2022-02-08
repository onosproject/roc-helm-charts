// SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
//
// SPDX-License-Identifier: Apache-2.0

package tests

import (
	"context"
	"testing"
	"time"

	"github.com/onosproject/helmit/pkg/helm"
	"github.com/onosproject/helmit/pkg/input"
	"github.com/onosproject/helmit/pkg/kubernetes"
	"github.com/onosproject/helmit/pkg/test"
	"github.com/onosproject/onos-test/pkg/onostest"
	"github.com/stretchr/testify/assert"
)

const aetherCharts = "https://charts.aetherproject.org/"

// AetherRocUmbrellaSuite is the aether-roc-umbrella chart test suite
type AetherRocUmbrellaSuite struct {
	test.Suite
	c *input.Context
}

// SetupTestSuite sets up the aether roc umbrella test suite
func (s *AetherRocUmbrellaSuite) SetupTestSuite(c *input.Context) error {
	s.c = c
	return nil
}

func getCredentials() (string, string, error) {
	kubClient, err := kubernetes.New()
	if err != nil {
		return "", "", err
	}
	secrets, err := kubClient.CoreV1().Secrets().Get(context.Background(), onostest.SecretsName)
	if err != nil {
		return "", "", err
	}
	username := string(secrets.Object.Data["sd-ran-username"])
	password := string(secrets.Object.Data["sd-ran-password"])

	return username, password, nil
}

// TestInstall tests installing the aether-roc-umbrella chart
func (s *AetherRocUmbrellaSuite) TestInstall(t *testing.T) {
	username, password, err := getCredentials()
	assert.NoError(t, err)
	registry := s.c.GetArg("registry").String("")

	onos := helm.Chart("aether-roc-umbrella", aetherCharts).
		Release("aether-roc-umbrella").
		SetUsername(username).
		SetPassword(password).
		WithTimeout(15*time.Minute).
		Set("import.onos-gui.enabled", false).
		Set("import.aether-roc-gui.v3.enabled", false).
		Set("import.aether-roc-gui.v4.enabled", true).
		Set("import.sdcore-adapter.v3.enabled", true).
		Set("import.sdcore-adapter.v4.enabled", true).
		Set("import.onos-cli.enabled", false).
		Set("import.prometheus.acc.enabled", false).
		Set("aether-roc-gui-v4.prometheus.acc.proxyEnabled", false).
		Set("import.prometheus.amp.enabled", false).
		Set("aether-roc-gui-v4.prometheus.amp.proxyEnabled", false).
		Set("import.prometheus.ace.enabled", false).
		Set("aether-roc-gui-v4.prometheus.site", nil).
		Set("import.grafana.enabled", false).
		Set("aether-roc-gui-v4.grafana.enabled", false).
		Set("aether-roc-gui-v4.grafana.proxyEnabled", false).
		Set("aether-roc-gui-v4.service.type", "NodePort").
		Set("onos-config.plugin.compiler.target", "github.com/onosproject/onos-config@master").
		Set("global.image.registry", registry)
	assert.NoError(t, onos.Install(true))
}
