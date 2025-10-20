package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
not has_readiness_probe(container)
msg := {
"message": sprintf("Container '%v' must have a readinessProbe configured", [container.name]),
"severity": "violation"
}
}

has_readiness_probe(container) if {
container.readinessProbe != null
}
