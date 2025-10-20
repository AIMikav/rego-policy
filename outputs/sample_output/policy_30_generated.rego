package policy

deny contains msg if {
input.input.review.object.kind == "DeploymentConfig"
input.input.review.object.apiVersion != "apps.openshift.io/v1"
msg := {
"message": "DeploymentConfig no longer served by v1",
"severity": "violation"
}
}
