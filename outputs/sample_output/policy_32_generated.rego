package policy

deny contains msg if {
input.input.review.object.kind == "ProjectRequest"
input.input.review.object.apiVersion != "project.openshift.io/v1"
msg := {
"message": "ProjectRequest resources must use the correct API version: project.openshift.io/v1",
"severity": "violation",
}
}
