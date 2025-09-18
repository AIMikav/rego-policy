package ocp.bestpractices.container_volumemount_missing

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00018")
  some volume in openshift.pod.spec.volumes

  not _containers_volumemounts_contains_volume(openshift.containers, volume)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: volume '%s' does not have a volumeMount in any of the containers.", [konstraint_core.kind, konstraint_core.name, volume.name]), "RHCOP-OCP_BESTPRACT-00018")
}

_containers_volumemounts_contains_volume(containers, volume) {
  containers[_].volumeMounts[_].name == volume.name
}