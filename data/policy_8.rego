package ocp.bestpractices.container_liveness_readinessprobe_equal

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00007")
  some container in openshift.containers

  container.livenessProbe == container.readinessProbe

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' livenessProbe and readinessProbe are equal, which is an anti-pattern.", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00007")
}