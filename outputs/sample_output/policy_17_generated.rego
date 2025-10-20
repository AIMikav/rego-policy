package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
has_secret_env(container)
msg := {
"message": "Container has secret mounted as environment variable. Use volume mounts instead.",
"severity": "violation",
}
}

has_secret_env(container) if {
some env in container.env
env.valueFrom.secretKeyRef != null
}
