package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
not has_expected_layers(container.imageHistory)
msg := {
"message": "PodmanHistory did not find expected SHA layer",
"severity": "violation",
}
}

has_expected_layers(imageHistory) if {
expected := input.parameters.expectedLayers
every layer in expected {
layer_found(layer, imageHistory)
}
}

layer_found(layer, imageHistory) if {
some historyLayer in imageHistory
historyLayer.id == layer
}
