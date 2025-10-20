package policy

deny contains msg if {
not has_owner_reference
input.input.review.object.kind == "Pod"
msg := {
"message": "Pods should be managed by controllers like Deployments, StatefulSets, or DaemonSets",
"severity": "violation",
}
}

has_owner_reference if {
count(input.input.review.object.metadata.ownerReferences) > 0
}
