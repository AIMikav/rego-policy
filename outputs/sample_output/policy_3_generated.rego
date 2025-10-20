package policy

deny contains msg if {
has_java_label
container := input.input.review.object.spec.containers[_]
not has_container_max_memory(container)
msg := {
"message": "Java container must have CONTAINER_MAX_MEMORY environment variable set with valueFrom.resourceFieldRef.resource=limits.memory",
"severity": "violation",
}
}

has_java_label if {
input.input.review.object.metadata.labels["redhat-cop.github.com/technology"] == "java"
}

has_container_max_memory(container) if {
some env_var in container.env
env_var.name == "CONTAINER_MAX_MEMORY"
env_var.valueFrom.resourceFieldRef.resource == "limits.memory"
}
