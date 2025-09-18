package ocp.bestpractices.deploymentconfig_triggers_containername

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00027")
  openshift.is_deploymentconfig

  some trigger in konstraint_core.resource.spec.triggers
  some container_name in trigger.imageChangeParams.containerNames

  not _containers_contains_trigger(openshift.containers, container_name)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: has a imageChangeParams trigger with a miss-matching container name for '%s'", [konstraint_core.kind, konstraint_core.name, container_name]), "RHCOP-OCP_BESTPRACT-00027")
}

_containers_contains_trigger(containers, container_name) {
  some container in containers
  container.name == container_name
}