package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
exceeds_memory_limit(container)
msg := {
"message": "Container memory request exceeds the upper limit of 2Gi",
"severity": "violation"
}
}

exceeds_memory_limit(container) if {
container.resources.requests.memory
memory_request := container.resources.requests.memory
memory_bytes := parse_memory(memory_request)
memory_bytes > 2147483648 # 2Gi in bytes
}

parse_memory(memory) = bytes if {
endswith(memory, "Gi")
num := trim_suffix(memory, "Gi")
bytes := to_number(num) * 1024 * 1024 * 1024
}

parse_memory(memory) = bytes if {
endswith(memory, "Mi")
num := trim_suffix(memory, "Mi")
bytes := to_number(num) * 1024 * 1024
}

parse_memory(memory) = bytes if {
endswith(memory, "Ki")
num := trim_suffix(memory, "Ki")
bytes := to_number(num) * 1024
}

parse_memory(memory) = bytes if {
endswith(memory, "m")
num := trim_suffix(memory, "m")
bytes := to_number(num) / 1000
}

parse_memory(memory) = to_number(memory) if {
is_number(memory)
}
