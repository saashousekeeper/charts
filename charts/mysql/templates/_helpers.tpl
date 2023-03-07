
{{- define "mysql.fullname" -}}
{{ include "mysql.fullname" . }}-mysql
{{- end }}

{{- define "mysql.config" -}}
{{ include "mysql.fullname" . }}-config
{{- end }}

{{- define "mysql.secret" -}}
{{ include "mysql.fullname" . }}-secret
{{- end }}

{{- define "mysql.secret-root" -}}
{{ include "mysql.fullname" . }}-secret-root
{{- end }}

{{- define "mysql.root-password" -}}
{{- if .Values.mysql.root_password }}
{{- .Values.mysql.root_password | b64enc }}
{{- else }}
{{- $secret := (lookup "v1" "Secret" .Release.Namespace (include "mysql.secret-root" .) ) -}}
{{- if $secret }}
{{- $secret.data.MYSQL_ROOT_PASSWORD }}
{{- else }}
{{- if .Values.mysql.generate_passwords }}
{{- randAlphaNum 16 | b64enc }}
{{- else }}
{{- "kubevious" | b64enc }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}


{{- define "mysql.host" -}}
{{- if .Values.mysql.external.enabled }}
{{- .Values.mysql.external.host }}
{{- else }}
{{- include "mysql.fullname" . }}
{{- end }}
{{- end }}


{{- define "mysql.port" -}}
{{- if .Values.mysql.external.enabled }}
{{- .Values.mysql.external.port }}
{{- else }}
{{- .Values.mysql.service.port }}
{{- end }}
{{- end }}


{{- define "mysql.database" -}}
{{- if .Values.mysql.external.enabled }}
{{- .Values.mysql.external.database }}
{{- else }}
{{- .Values.mysql.db_name }}
{{- end }}
{{- end }}


{{- define "mysql.user" -}}
{{- if .Values.mysql.external.enabled }}
{{- .Values.mysql.external.user }}
{{- else }}
{{- .Values.mysql.db_user }}
{{- end }}
{{- end }}


{{- define "mysql.user-password" -}}
{{- .Values.mysql.external.password | b64enc }}
{{- if .Values.mysql.external.enabled }}
{{- else }}
{{- if and (.Values.mysql.db_user) (not (eq .Values.mysql.db_user "root")) }}
{{- if .Values.mysql.db_password }}
{{- .Values.mysql.db_password | b64enc }}
{{- else }}
{{- $secret := (lookup "v1" "Secret" .Release.Namespace (include "mysql.secret" .) ) -}}
{{- if $secret }}
{{- $secret.data.MYSQL_PASS }}
{{- else }}
{{- if .Values.mysql.generate_passwords }}
{{- randAlphaNum 16 | b64enc }}
{{- else }}
{{- "kubevious" | b64enc }}
{{- end }}
{{- end }}
{{- end }}
{{- else }}
{{- include "mysql.root-password" . }}
{{- end }}
{{- end }}
{{- end }}


{{/*
Create the name of the service account to use for mysql
*/}}
{{- define "mysql.serviceAccountName" -}}
{{- if .Values.mysql.serviceAccount.create }}
{{- default (include "mysql.fullname" .) .Values.mysql.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.mysql.serviceAccount.name }}
{{- end }}
{{- end }}