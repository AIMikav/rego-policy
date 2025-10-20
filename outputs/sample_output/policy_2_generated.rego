package policy

deny contains msg if {
resource := input.input.review.object
is_networking_resource(resource.kind)
not has_required_labels(resource)
msg := {
"message": "Networking resource is missing required Kubernetes recommended labels: app.kubernetes.io/name, app.kubernetes.io/instance, app.kubernetes.io/version, app.kubernetes.io/component, app.kubernetes.io/part-of, app.kubernetes.io/managed-by",
"severity": "violation",
}
}

deny contains msg if {
resource := input.input.review.object
resource.kind == "Pod"
not has_required_labels(resource)
msg := {
"message": "Pod is missing required Kubernetes recommended labels: app.kubernetes.io/name, app.kubernetes.io/instance, app.kubernetes.io/version, app.kubernetes.io/component, app.kubernetes.io/part-of, app.kubernetes.io/managed-by",
"severity": "violation",
}
}

has_required_labels(resource) if {
labels := resource.metadata.labels
labels != null
labels["app.kubernetes.io/name"] != null
labels["app.kubernetes.io/instance"] != null
labels["app.kubernetes.io/version"] != null
labels["app.kubernetes.io/component"] != null
labels["app.kubernetes.io/part-of"] != null
labels["app.kubernetes.io/managed-by"] != null
}

is_networking_resource(kind) if {
kind == "NetworkPolicy"
}

is_networking_resource(kind) if {
kind == "Ingress"
}

is_networking_resource(kind) if {
kind == "Service"
}
