package policy

deny contains msg if {
input.input.review.object.apiVersion == "authorization.openshift.io/v1"
msg := {
"message": "RBAC resources must not use the deprecated 'authorization.openshift.io' API group. Migrate to rbac.authorization.k8s.io/v1.",
"severity": "violation",
}
}
