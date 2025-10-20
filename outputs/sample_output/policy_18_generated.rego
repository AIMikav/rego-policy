package policy

deny contains msg if {
container := input.input.review.object.spec.containers[_]
mount := container.volumeMounts[_]
not is_valid_mount_path(mount.mountPath)
msg := {
"message": sprintf("Container '%v' has invalid volume mount path '%v'. Mount paths must follow the pattern /var/run/{organization}/{mount}", [container.name, mount.mountPath]),
"severity": "violation",
}
}

is_valid_mount_path(path) if {
startswith(path, "/var/run/")
parts := split(path, "/")
count(parts) >= 4
}
