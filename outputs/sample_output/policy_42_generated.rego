package policy

deny contains msg if {
input.input.review.object.apiVersion == "operators.coreos.com/v1"
input.input.review.object.kind == "OperatorSource"
msg := {
"message": "operators.coreos.com v1 OperatorSource is deprecated. This API is deprecated in OCP 4.2 and will be removed in a future version. See: https://docs.redhat.com/en/documentation/openshift_container_platform/4.2/html/release_notes/ocp-4-2-release-notes#ocp-4-2-deprecated-features",
"severity": "violation",
}
}
