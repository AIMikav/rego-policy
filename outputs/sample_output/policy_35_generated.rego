package policy

deny contains msg if {
input.input.review.kind.kind == "SecurityContextConstraints"
input.input.review.object.apiVersion != "security.openshift.io/v1"
msg := {
"message": "SecurityContextConstraints resources must use the correct API version: security.openshift.io/v1",
"severity": "violation",
}
}
