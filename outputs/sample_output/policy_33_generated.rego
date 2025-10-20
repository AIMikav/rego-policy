package policy

deny contains msg if {
input.input.review.object.kind == "RoleBinding"
input.input.review.object.apiVersion != "rbac.authorization.k8s.io/v1"
msg := {
"message": "RoleBinding resources must use apiVersion rbac.authorization.k8s.io/v1",
"severity": "violation",
}
}
