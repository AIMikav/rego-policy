package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
not is_valid_registry(container.image)
msg := {
"message": sprintf("Container image '%v' is not from a known registry", [container.image]),
"severity": "violation"
}
}

is_valid_registry(image) if {
known_registries := ["image-registry.openshift-image-registry.svc", "registry.redhat.io", "registry.connect.redhat.com", "quay.io"]
registry := get_registry(image)
registry in known_registries
}

get_registry(image) = registry if {
parts := split(image, "/")
count(parts) > 1
registry := parts[0]
not contains(registry, ":")  # Exclude registries with ports.
}

get_registry(image) = "docker.io" if {
parts := split(image, "/")
count(parts) == 1
}
