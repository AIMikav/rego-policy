package policy

deny contains msg if {
input.input.review.object.kind == "BuildConfig"
input.input.review.object.apiVersion != "build.openshift.io/v1"
msg := {
"message": "BuildConfig resources must use build.openshift.io/v1 API version.",
"severity": "violation",
}
}
