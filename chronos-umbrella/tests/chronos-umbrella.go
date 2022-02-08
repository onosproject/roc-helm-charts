// SPDX-FileCopyrightText: 2021-present Open Networking Foundation <info@opennetworking.org>
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

// ChronosUmbrellaSuite is the chronos-umbrella chart test suite
type ChronosUmbrellaSuite struct {
	test.Suite
	c *input.Context
}

// SetupTestSuite sets up the chronos umbrella test suite
func (s *ChronosUmbrellaSuite) SetupTestSuite(c *input.Context) error {
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

// TestInstall tests installing the chronos-umbrella chart
func (s *ChronosUmbrellaSuite) TestInstall(t *testing.T) {
	username, password, err := getCredentials()
	assert.NoError(t, err)
	registry := s.c.GetArg("registry").String("")

	onos := helm.Chart("chronos-umbrella", aetherCharts).
		Release("chronos-umbrella").
		SetUsername(username).
		SetPassword(password).
		WithTimeout(15*time.Minute).
		Set("import.prometheus.chronos.enabled", false).
		Set("global.image.registry", registry)
	assert.NoError(t, onos.Install(true))
}
