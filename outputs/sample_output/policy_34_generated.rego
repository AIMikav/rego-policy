package policy

deny contains msg if {
input.input.review.object.kind == "Route"
input.input.review.object.apiVersion != "route.openshift.io/v1"
msg := {
"message": "Route resources must use apiVersion route.openshift.io/v1",
"severity": "violation",
}
}
