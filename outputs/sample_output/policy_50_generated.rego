package policy

deny contains msg if {
service := input.input.review.object
service.kind == "Service"
not has_matching_service_monitor(service)
msg := {
"message": sprintf("Service '%v/%v' does not have a matching ServiceMonitor", [service.metadata.namespace, service.metadata.name]),
"severity": "violation",
}
}

has_matching_service_monitor(service) if {
some monitor in get_service_monitors
monitor.spec.selector == service.spec.selector
monitor.metadata.namespace == service.metadata.namespace
}

get_service_monitors = monitors if {
monitors := [monitor |
monitor := data.kubernetes.objects[_]
monitor.kind == "ServiceMonitor"
monitor.apiVersion == "monitoring.coreos.com/v1"
]
}
