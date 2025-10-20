package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
identical_probes(container)
msg := {
"message": "Container livenessProbe and readinessProbe must not be identical",
"severity": "violation"
}
}

identical_probes(container) if {
container.livenessProbe == container.readinessProbe
container.livenessProbe != null
container.readinessProbe != null
}
