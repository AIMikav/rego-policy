package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
not has_liveness_probe(container)
msg := {
"message": sprintf("Container '%v' must have a livenessProbe configured", [container.name]),
"severity": "violation",
}
}

has_liveness_probe(container) if {
container.livenessProbe != null
}
