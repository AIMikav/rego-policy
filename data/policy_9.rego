package ocp.bestpractices.container_livenessprobe_notset

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00008")
  some container in openshift.containers

  konstraint_core.missing_field(container, "livenessProbe")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has no livenessProbe. See: https://docs.redhat.com/en/documentation/openshift_container_platform/4.18/html/building_applications/application-health", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00008")
}