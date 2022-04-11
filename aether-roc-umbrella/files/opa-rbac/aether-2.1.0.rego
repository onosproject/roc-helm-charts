# SPDX-FileCopyrightText: 2022-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

package aether_2_1_x

echo[config] {
    config := input
}

allowed[config] {
    application := application_rule
    site := site_rule
    template := template_rule
    traffic_class := traffic_class_rule
    config := {
        "application": application,
        "site": site,
        "template": template,
        "traffic_class": traffic_class
    }
}

application_rule[application] {
    ["AetherROCAdmin", input.target][_] == input.groups[i]
    application := input.application
}

site_rule[site] {
    ["AetherROCAdmin", input.target][_] == input.groups[i]
    site := input.site
}

template_rule[template] {
    ["AetherROCAdmin", input.target][_] == input.groups[i]
    template := input.template
}

traffic_class_rule[traffic_class] {
    ["AetherROCAdmin", input.target][_] == input.groups[i]
    traffic_class := input.traffic_class
}

can_update_enterprise = true {
    update_enterprise := input.updates.enterprises.enterprise[_]
    ["AetherROCAdmin", update_enterprise.enterprise_id][_] == input.groups[i]
}
