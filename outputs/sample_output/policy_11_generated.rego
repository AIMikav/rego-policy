package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
has_cpu_limits(container)
msg := {
"message": "Containers should not have CPU limits set.",
"severity": "violation",
}
}

has_cpu_limits(container) if {
container.resources.limits.cpu
}
