# SPDX-FileCopyrightText: 2021-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: LicenseRef-ONF-Member-Only-1.0

.PHONY: all test clean

all: test

test: # @HELP run the integration tests
test: deps
	./build/bin/run-roc-test

clean: # @HELP clean up temporary files for ROC umbrella.
	rm -rf aether-roc-umbrella/charts aether-roc-umbrella/Chart.lock

deps: # @HELP build dependencies for ROC Umbrella local charts.
deps: clean
	helm dep build aether-roc-umbrella

help:
	@grep -E '^.*: *# *@HELP' $(MAKEFILE_LIST) \
    | sort \
    | awk ' \
        BEGIN {FS = ": *# *@HELP"}; \
        {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}; \
    '
