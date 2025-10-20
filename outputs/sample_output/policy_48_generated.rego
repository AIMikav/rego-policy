package policy

deny contains msg if {
deployment := input.input.review.object
deployment.kind == "Deployment"
not has_matching_service(deployment)
msg := {
"message": sprintf("Deployment '%v' in namespace '%v' does not have a matching Service", [deployment.metadata.name, deployment.metadata.namespace]),
"severity": "violation"
}
}

has_matching_service(deployment) if {
some service in input.input.review.object.items
service.kind == "Service"
service.metadata.namespace == deployment.metadata.namespace
deployment_labels := deployment.spec.template.metadata.labels
service_selector := service.spec.selector
matching_labels(deployment_labels, service_selector)
}

matching_labels(deployment_labels, service_selector) if {
all key, value in service_selector {
deployment_labels[key] == value
}
}
