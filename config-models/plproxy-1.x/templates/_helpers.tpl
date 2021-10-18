// SPDX-FileCopyrightText: 2021 Open Networking Foundation
//
// SPDX-License-Identifier: LicenseRef-ONF-Member-Only-1.0

{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "plproxy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "plproxy.fullname" -}}
{{- if contains "config-model-plproxy" .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Chart.AppVersion | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-config-model-plproxy" .Release.Name .Chart.AppVersion | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "plproxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Common labels
*/}}
{{- define "plproxy.labels" -}}
helm.sh/chart: {{ include "plproxy.chart" . }}
{{ include "plproxy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "plproxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "plproxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
}
