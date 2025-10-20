package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
image_size_exceeds_limit(container.image, input.parameters.image_size_upperbound)
msg := {
"message": sprintf("Image '%v' exceeds the maximum allowed size of %v", [container.image, input.parameters.image_size_upperbound]),
"severity": "violation",
}
}

image_size_exceeds_limit(image, upperbound) if {
count(image) > upperbound
}
