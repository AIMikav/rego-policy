package policy

deny contains msg if {
some namespace in namespaces
not has_resource_quota
msg := {
"message": sprintf("Namespace '%v' must have a ResourceQuota", [namespace.metadata.name]),
"severity": "violation",
}
}

namespaces contains item if {
some item in input.input.items
item.kind == "Namespace"
}

namespaces contains item if {
some item in input.input
item.kind == "Namespace"
}

namespaces contains item if {
input.input.kind == "Namespace"
item := input.input
}

has_resource_quota if {
some item in input.input.items
item.kind == "ResourceQuota"
}

has_resource_quota if {
some item in input.input
item.kind == "ResourceQuota"
}
