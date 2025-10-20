package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
exceeds_memory_limit(container)
msg := {
"message": sprintf("Container '%v' memory limit exceeds the upper limit of 6Gi.", [container.name]),
"severity": "violation",
}
}

exceeds_memory_limit(container) if {
container.resources.limits.memory
memory := container.resources.limits.memory
memory != ""
not startswith(memory, "$")  # Exclude variable substitutions
memory_bytes := parse_memory(memory)
memory_bytes > 6 * 1024 * 1024 * 1024 # 6Gi in bytes
}

parse_memory(memory) = bytes if {
endswith(memory, "Gi")
num := trim_suffix(memory, "Gi")

is_number(num)
bytes := to_number(num) * 1024 * 1024 * 1024 # Convert Gi to bytes
}

parse_memory(memory) = bytes if {
endswith(memory, "Mi")
num := trim_suffix(memory, "Mi")
is_number(num)
bytes := to_number(num) * 1024 * 1024 # Convert Mi to bytes
}

