# SPDX-FileCopyrightText: 2022-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

package aether_2_0_x

echo[config] {
    config := input
}

allowed[config] {
    enterprise := enterprise_rule
    config := {
        "connectivity_services": object.get(input, "connectivity_services", {}),
        "enterprises": {
            "enterprise": [
                enterprise
            ]
        }
    }
}

enterprise_rule[enterprise] {
    enterprise := input.enterprises.enterprise[_]
    ["AetherROCAdmin", enterprise.enterprise_id][_] == input.groups[i]
}

can_update_enterprise = true {
    update_enterprise := input.updates.enterprises.enterprise[_]
    ["AetherROCAdmin", update_enterprise.enterprise_id][_] == input.groups[i]
}
