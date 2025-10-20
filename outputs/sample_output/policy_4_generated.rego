package policy

deny contains msg if {
container := input.input.review.object.spec.template.spec.containers[_]
has_latest_tag(container.image)
msg := {
"message": sprintf("Container image '%v' should not use the 'latest' tag", [container.image]),
"severity": "violation",
}
}

has_latest_tag(image) if {
endswith(image, ":latest")
}
