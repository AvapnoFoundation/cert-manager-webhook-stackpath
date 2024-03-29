{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "cert-manager-webhook-stackpath.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cert-manager-webhook-stackpath.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cert-manager-webhook-stackpath.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "cert-manager-webhook-stackpath.labels" -}}
app.kubernetes.io/name: {{ include "cert-manager-webhook-stackpath.name" . }}
helm.sh/chart: {{ include "cert-manager-webhook-stackpath.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "cert-manager-webhook-stackpath.stack" -}}
{{- .Release.Name -}}
{{- end -}}

{{- define "cert-manager-webhook-stackpath.selfSignedIssuer" -}}
{{ printf "%s-selfsign" (include "cert-manager-webhook-stackpath.fullname" .) }}
{{- end -}}

{{- define "cert-manager-webhook-stackpath.rootCAIssuer" -}}
{{- if .Values.existingIssuer -}}
{{ .Values.existingIssuer }}
{{- else -}}
{{ printf "%s-ca" (include "cert-manager-webhook-stackpath.fullname" .) }}
{{- end -}}
{{- end -}}

{{- define "cert-manager-webhook-stackpath.rootCACertificate" -}}
{{ printf "%s-ca" (include "cert-manager-webhook-stackpath.fullname" .) }}
{{- end -}}

{{- define "cert-manager-webhook-stackpath.servingCertificate" -}}
{{ printf "%s-webhook-tls" (include "cert-manager-webhook-stackpath.fullname" .) }}
{{- end -}}
