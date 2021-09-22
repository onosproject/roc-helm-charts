<!--
SPDX-FileCopyrightText: 2021 Open Networking Foundation

SPDX-License-Identifier: LicenseRef-ONF-Member-Only-1.0
-->
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

