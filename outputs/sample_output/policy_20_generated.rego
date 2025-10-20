package policy

deny contains msg if {
not has_triggers
msg := {
"message": "DeploymentConfig has no triggers set. If no triggers are needed, consider using a native Kubernetes Deployment instead. See: https://kubernetes.io/docs/concepts/workloads/controllers/deployment",
"severity": "violation",
}
}

has_triggers if {
input.input.review.object.kind == "DeploymentConfig"
count(input.input.review.object.spec.triggers) > 0
}
