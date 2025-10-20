package policy

deny contains msg if {
resource := input.input.review.object
is_deployment(resource)
not is_odd(resource.spec.replicas)
msg := {
"message": "Deployment replicas must be an odd number for HA guarantees.",
"severity": "violation"
}
}

is_deployment(resource) if {
resource.kind == "Deployment"
}

is_odd(num) if {
is_number(num)
num % 2 != 0
}
