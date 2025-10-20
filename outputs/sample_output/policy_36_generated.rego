package policy

deny contains msg if {
input.input.review.object.kind == "Template"
input.input.review.object.apiVersion != "template.openshift.io/v1"
msg := {
"message": "Template resources must use the correct API version template.openshift.io/v1.",
"severity": "violation"
}
}
