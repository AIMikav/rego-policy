package policy

deny contains msg if {
input.input.review.object.apiVersion == "servicecatalog.k8s.io/v1beta1"
msg := {
"message": "Service catalog resources must not use the deprecated 'servicecatalog.k8s.io/v1beta1' API.",
"severity": "violation",
}
}
