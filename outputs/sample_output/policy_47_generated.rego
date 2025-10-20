package policy

deny contains msg if {
deployment := input.input.review.object
deployment.kind == "Deployment"
volume := deployment.spec.template.spec.volumes[_]
volume.persistentVolumeClaim != null
not persistent_volume_claim_exists(deployment.metadata.namespace, volume.persistentVolumeClaim.claimName)
msg := {
"message": sprintf("Deployment '%v' has PersistentVolumeClaim '%v' but no matching PVC found in namespace '%v'", [deployment.metadata.name, volume.persistentVolumeClaim.claimName, deployment.metadata.namespace]),
"severity": "violation",
}
}

persistent_volume_claim_exists(namespace, claimName) if {
pvcs := get_persistent_volume_claims(namespace)
some pvc in pvcs
pvc.metadata.name == claimName
}

get_persistent_volume_claims(namespace) = pvcs if {
pvcs := [pvc | pvc := data.kubernetes.persistentvolumeclaims[namespace][_]]
}
