package policy

deny contains msg if {
input_object := input.input.review.object
input_object.kind == "Deployment"
has_service_account_name(input_object)
not service_account_exists(input_object)
msg := {
"message": sprintf("Deployment '%v' specifies serviceAccountName '%v' but no matching ServiceAccount was found.", [input_object.metadata.name, input_object.spec.template.spec.serviceAccountName]),
"severity": "violation",
}
}

has_service_account_name(obj) if {
obj.spec.template.spec.serviceAccountName != ""
}

service_account_exists(obj) if {
service_account_name := obj.spec.template.spec.serviceAccountName
namespace := obj.metadata.namespace
some sa in input.input.review.resolvedObjects
sa.kind == "ServiceAccount"
sa.metadata.name == service_account_name
sa.metadata.namespace == namespace
}
