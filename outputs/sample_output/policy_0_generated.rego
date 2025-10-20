package policy

deny contains msg if {
some namespace in namespaces
not has_network_policy(namespace)
msg := {
"message": sprintf("Namespace '%v' must have a NetworkPolicy", [namespace.metadata.name]),
"severity": "violation"
}
}

namespaces contains item if {
some item in input.input.items
item.kind == "Namespace"
}

has_network_policy(namespace) if {
some policy in input.input.items
policy.kind == "NetworkPolicy"
}
