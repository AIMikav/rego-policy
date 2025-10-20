package policy

deny contains msg if {
input.input.review.object.apiVersion == "automationbroker.io/v1alpha1"
msg := {
"message": "automationbroker.io v1alpha1 is deprecated",
"severity": "violation",
}
}
