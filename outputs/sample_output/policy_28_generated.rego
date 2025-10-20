package policy

deny contains msg if {
deployment_config := input.input.review.object
deployment_config.kind == "DeploymentConfig"
some trigger in deployment_config.spec.triggers
trigger.type == "ImageChange"
trigger_container_name := trigger.imageChangeParams.containerName
not container_exists(deployment_config.spec.template.spec.containers, trigger_container_name)
msg := {
"message": sprintf("DeploymentConfig '%v' has a trigger with container name '%v' which does not exist in the pod template", [deployment_config.metadata.name, trigger_container_name]),
"severity": "violation"
}
}

container_exists(containers, container_name) if {
some container in containers
container.name == container_name
}
