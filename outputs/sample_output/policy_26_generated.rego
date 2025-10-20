package policy

deny contains msg if {
route := input.input.review.object
route.kind == "Route"
not has_tls_termination(route)
msg := {
"message": "Route must have TLS termination configured",
"severity": "violation",
}
}

has_tls_termination(route) if {
route.spec.tls.termination != ""
}
