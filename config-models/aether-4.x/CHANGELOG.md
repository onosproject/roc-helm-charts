<!--
SPDX-FileCopyrightText: 2021 Open Networking Foundation

SPDX-License-Identifier: Apache-2.0
-->

Changes on 11/1/2021
====================
Application.Endpoint:
  * add `display-name` and rename `name` to `id`

Device-Group.Imsi:
  * add `display-name` and rename `name` to `id`

Site:
  * small-cell: add `display-name` and rename `name` to `id`
  * edge-device: rename `name` to `id`


Changes on 10/19/2021
=====================

Device-Group:
  * Device.MBR and Device.Traffic-Class set to mandatory

VCS:
  * Add Allow-Internet boolean
  * Restricted application filter priority to 0-200.
  * Remove link to template

Template:
  * Add Allow-Internet boolean
  * Remove Traffic-Class and Device.MBR

Changes on 10/21/2021
=====================
Connectivity-Service
  * Add acc-prometheus-url

Changes on 10/13/2021
=====================
Application
  * Add Traffic-Class to Application
  * Add Site to UPF
  * Add Device.Mbr.<Uplink,Downlink> to DeviceGroup

Differences from Aether-3.0.0
=============================

VCS and Template:
  * Containerized device MBR Uplink and Download to device.mbr.uplink and device.mbr.downlink
  * Added slice.mbr.uplink and slice.mbr.downlink
  * Remove link to AP-List
  * All bitrates are now uint64 and have units "bps"
  * Renamed the application section to "filter"
  * Added priority to application filters

Site:
  * Added link to AP-List
  * Now includes a list of access points
  * Small-cell (formerly access-point) list includes a name for each AP

Application:
  * Added mbr.uplink and mbr.downlink
  * Moved address outside of the endpoint list

Traffic-Class:
  * Removed pelr and pdb
  * Added arp

AP-List
  * Removed; contents added to slice

UPF:
  * Added config-endpoint

Models prefixed with onf- throughout.

Application Filtering
=====================

Application filtering is part of this release. A brief description of Application
Filtering is below.

* Each VCS contains a filter
* The filter is a list of applications. Each application within the filter can
  be set to Allow or Deny and can be given a priority.
* The filter is executed in priority order. The first application to match a packet will
  have its resulting action (Allow or Deny) executed for that packet.
* Each application contains a single address and a set of endpoints.
* Each endpoint is a port-range together with a maximum bitrate.

