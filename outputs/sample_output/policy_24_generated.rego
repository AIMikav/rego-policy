package policy

deny contains msg if {
input.input.review.object.kind == "RoleBinding"
not has_api_group(input.input.review.object.roleRef)
msg := {
"message": "RoleBinding must have roleRef.apiGroup set",
"severity": "violation",
}
}

has_api_group(roleRef) if {
roleRef.apiGroup != ""
roleRef.apiGroup != null
}
