package policy

deny contains msg if {
not has_anti_affinity
msg := {
"message": "Pod must have anti-affinity rules configured for high availability.",
"severity": "violation"
}
}

has_anti_affinity if {
input.input.review.object.spec.affinity.podAntiAffinity != null
}
