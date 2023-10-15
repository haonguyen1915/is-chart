{{- define "gitlab-runner.runner-env-vars" }}
- name: CI_SERVER_URL
  value: {{ include "gitlab-runner.gitlabUrl" . }}
- name: RUNNER_EXECUTOR
  value: {{ default "kubernetes" .Values.runners.executor | quote }}
- name: REGISTER_LOCKED
  {{ if or (not (hasKey .Values.runners "locked")) .Values.runners.locked -}}
  value: "true"
  {{- else -}}
  value: "false"
  {{- end }}
- name: RUNNER_TAG_LIST
  value: {{ default "" .Values.runners.tags | quote }}
{{- if eq (default "kubernetes" .Values.runners.executor) "kubernetes" }}
{{- if or .Values.runners.namespace (not (regexMatch "\\s*namespace\\s*=" .Values.runners.config)) }}
- name: KUBERNETES_NAMESPACE
  value: {{ .Release.Namespace | quote }}
{{- end }}
{{- end }}
{{- if .Values.envVars -}}
{{ range .Values.envVars }}
- name: {{ .name }}
  value: {{ .value | quote }}
{{- end }}
{{- end }}
{{- end }}
