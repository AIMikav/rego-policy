package policy

deny contains msg if {
input.input.review.object.kind == "RoleBinding"
not has_role_ref_kind(input.input.review.object)
msg := {
"message": "RoleBinding must have roleRef.kind set",
"severity": "violation",
}
}

has_role_ref_kind(rolebinding) if {
rolebinding.roleRef.kind != ""
}
