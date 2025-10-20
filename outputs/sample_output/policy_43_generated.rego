package policy

deny contains msg if {
input.input.review.object.apiVersion == "osb.openshift.io/v1"
input.input.review.object.kind == "AutomationBroker"
msg := {
"message": "AutomationBroker resources must not use the deprecated 'osb.openshift.io/v1' API",
"severity": "violation",
}
}

deny contains msg if {
input.input.review.object.apiVersion == "osb.openshift.io/v1"
input.input.review.object.kind == "TemplateServiceBroker"
msg := {
"message": "TemplateServiceBroker resources must not use the deprecated 'osb.openshift.io/v1' API",
"severity": "violation",
}
}
