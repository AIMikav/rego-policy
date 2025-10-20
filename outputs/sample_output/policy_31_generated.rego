package policy

deny contains msg if {
input.input.review.object.kind == "ImageStream"
not is_valid_api_version(input.input.review.object.apiVersion)
msg := {
"message": "ImageStream resources must use image.openshift.io/v1 API version",
"severity": "violation",
}
}

is_valid_api_version(apiVersion) if {
apiVersion == "image.openshift.io/v1"
}
