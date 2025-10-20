package policy

deny contains msg if {
input.input.review.object.spec.hostNetwork == true
msg := {
"message": "Pod should not use hostNetwork due to security concerns",
"severity": "violation",
}
}
