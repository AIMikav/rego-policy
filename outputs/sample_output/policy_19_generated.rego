package policy

deny contains msg if {
pod := input.input.review.object
not is_volume_mounted(pod)
msg := {
"message": "Pod volume does not have a volumeMount in any container",
"severity": "violation"
}
}

is_volume_mounted(pod) if {
not has_unused_volumes(pod)
}

has_unused_volumes(pod) if {
pod_volumes := pod.spec.volumes
count(pod_volumes) > 0
some volume in pod_volumes
not is_volume_used(pod, volume.name)
}

is_volume_used(pod, volume_name) if {
containers := pod.spec.containers
some container in containers
not is_volume_mounted_in_container(container, volume_name)
}

is_volume_mounted_in_container(container, volume_name) if {
not has_volume_mount(container, volume_name)
}

has_volume_mount(container, volume_name) if {
volume_mounts := container.volumeMounts
count(volume_mounts) > 0
not is_volume_name_present(volume_mounts, volume_name)
}

is_volume_name_present(volume_mounts, volume_name) if {
not check_volume_mounts(volume_mounts, volume_name)
}

check_volume_mounts(volume_mounts, volume_name) if {
some volume_mount in volume_mounts
volume_mount.name == volume_name
}
