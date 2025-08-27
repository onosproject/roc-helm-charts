# SPDX-FileCopyrightText: 2021-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

.PHONY: all test clean

all: test

test: # @HELP run the acceptance tests
test: deps opa-test

opa-test: #@HELP run the rego rule tests
opa-test:
	@cd aether-roc-umbrella/files/opa-rbac && for test_file in test/*; do \
	trimmed=`basename $$test_file .json`;\
	case "$$trimmed" in \
	*2.0.0*) docker run --platform linux/amd64 -v $$(pwd):/opa-rbac openpolicyagent/opa:0.40.0 eval -f pretty -b /opa-rbac \
	--input opa-rbac/test/$$trimmed.json data.aether_2_0_x.allowed > /tmp/$$trimmed.out;;\
	*2.1.0*) docker run --platform linux/amd64 -v $$(pwd):/opa-rbac openpolicyagent/opa:0.40.0 eval -f pretty -b /opa-rbac \
	--input opa-rbac/test/$$trimmed.json data.aether_2_1_x.allowed > /tmp/$$trimmed.out;;\
	*) continue;;esac;\
	cmp -b /tmp/$$trimmed.out test/out/$$trimmed.out \
	&& echo "[TEST] $$trimmed.json : PASS"|| echo "[TEST] $$trimmed.json : FAIL";\
	done;

roc-test: # @HELP run the integration tests
roc-test: deps # @HELP run the integration tests
	./build/bin/run-roc-test

clean: # @HELP clean up temporary files for ROC umbrella.
	rm -rf aether-roc-umbrella/charts aether-roc-umbrella/Chart.lock

deps: # @HELP build dependencies for ROC Umbrella local charts.
deps: clean
	helm dep build aether-roc-umbrella

HELM_CHARTS := $(shell find . -type f -name 'Chart.yaml' -exec dirname {} \;)
.PHONY: helmlint
helmlint: deps ## lint helm charts
	@echo "Linting helm charts"
	set -e ;\
	$(foreach file,$(HELM_CHARTS),\
		helm lint $(file) ;\
    )

help:
	@grep -E '^.*: *# *@HELP' $(MAKEFILE_LIST) \
    | sort \
    | awk ' \
        BEGIN {FS = ": *# *@HELP"}; \
        {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}; \
    '

reuse-lint:
	reuse --root . lint
