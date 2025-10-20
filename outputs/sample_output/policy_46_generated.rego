package policy

deny contains msg if {
input.input.review.object.kind == "Deployment"
not has_matching_pdb
msg := {
"message": "Deployment does not have a matching PodDisruptionBudget",
"severity": "violation",
}
}

has_matching_pdb if {
deployment := input.input.review.object
deployment_labels := deployment.spec.template.metadata.labels
some pdb in get_pdbs
pdb_selector := pdb.spec.selector.matchLabels
is_subset(deployment_labels, pdb_selector)
}

get_pdbs = pdbs if {
pdbs := [pdb | pdb := data.kubernetes.poddisruptionbudgets[_]]
}

is_subset(a, b) if {
not object.empty(a)
all key, value in a {
b[key] == value
}
}
