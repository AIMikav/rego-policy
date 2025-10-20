package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
invalid_cpu_request(container)
msg := {
"message": "Container CPU resource requests must use correct units. Valid CPU units are: \"m\" (millicores) or \"\" (whole cores).",
"severity": "violation"
}
}

invalid_cpu_request(container) if {
request := container.resources.requests.cpu
not is_valid_cpu_request(request)
}

is_valid_cpu_request(request) if {
is_string(request)
endswith(request, "m")
}

is_valid_cpu_request(request) if {
is_number(request)
}

is_valid_cpu_request(request) if {
request == ""
}
