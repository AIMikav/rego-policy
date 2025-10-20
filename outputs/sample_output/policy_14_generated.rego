package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
invalid_memory_units(container)
msg := {
"message": "Container memory resources have incorrect units. Valid units are: Ei, Pi, Ti, Gi, Mi, Ki, E, P, T, G, M, K",
"severity": "violation",
}
}

invalid_memory_units(container) if {
not valid_memory_unit(container.resources.limits.memory)
}

invalid_memory_units(container) if {
not valid_memory_unit(container.resources.requests.memory)
}

valid_memory_unit(memory) if {
memory == null
}

valid_memory_unit(memory) if {
is_valid_memory_format(memory)
}

is_valid_memory_format(memory) if {
valid_units := ["Ei", "Pi", "Ti", "Gi", "Mi", "Ki", "E", "P", "T", "G", "M", "K"]
some unit in valid_units
endswith(memory, unit)
}
