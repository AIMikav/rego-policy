package policy

deny contains msg if {
resource := input.input.review.object
is_workload(resource.kind)
container := resource.spec.template.spec.containers[_]
has_xmx_arg(container)
not has_container_max_memory_env(container)
msg := {
"message": "Container in workload resource should not set -Xmx directly; use CONTAINER_MAX_MEMORY environment variable instead",
"severity": "violation",
}
}

is_workload(kind) if {
kind == "Pod"
}

is_workload(kind) if {
kind == "ReplicationController"
}

is_workload(kind) if {
kind == "DaemonSet"
}

is_workload(kind) if {
kind == "Deployment"
}

is_workload(kind) if {
kind == "Job"
}

is_workload(kind) if {
kind == "ReplicaSet"
}

is_workload(kind) if {
kind == "StatefulSet"
}

is_workload(kind) if {
kind == "DeploymentConfig"
}

is_workload(kind) if {
kind == "CronJob"
}

has_xmx_arg(container) if {
some arg in container.args
contains(arg, "-Xmx")
}

has_container_max_memory_env(container) if {
some env in container.env
env.name == "CONTAINER_MAX_MEMORY"
}
