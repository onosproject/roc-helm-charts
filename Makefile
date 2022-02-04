# SPDX-FileCopyrightText: 2021-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

.PHONY: all test clean

all: test

test: # @HELP run the acceptance tests
test: deps

roc-test: # @HELP run the integration tests
roc-test: deps # @HELP run the integration tests
	./build/bin/run-roc-test

clean: # @HELP clean up temporary files for ROC umbrella.
	rm -rf aether-roc-umbrella/charts aether-roc-umbrella/Chart.lock

deps: # @HELP build dependencies for ROC Umbrella local charts.
deps: clean
	helm dep build aether-roc-umbrella

deps-chronos: # @HELP build dependencies for Chronos Umbrella local charts.
deps-chronos: clean
	rm -rf chronos-umbrella/Chart.lock chronos-umbrella/charts
	helm dep build chronos-umbrella

help:
	@grep -E '^.*: *# *@HELP' $(MAKEFILE_LIST) \
    | sort \
    | awk ' \
        BEGIN {FS = ": *# *@HELP"}; \
        {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}; \
    '

reuse-lint:
	reuse --root . lint
