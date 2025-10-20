package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
not has_memory_limits(container)
msg := {
"message": sprintf("Container '%v' must have memory limits set", [container.name]),
"severity": "violation"
}
}

has_memory_limits(container) if {
container.resources.limits.memory != null
}

has_memory_limits(container) if {
container.resources.limits.memory != ""
}
