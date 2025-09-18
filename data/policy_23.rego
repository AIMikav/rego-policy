package ocp.bestpractices.pod_replicas_not_odd

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00022")
  openshift.pod

  replicas := konstraint_core.resource.spec.replicas
  replicas % 2 == 0

  msg := konstraint_core.format_with_id(sprintf("%s/%s: replicas is %d - expected an odd number for HA guarantees.", [konstraint_core.kind, konstraint_core.name, replicas]), "RHCOP-OCP_BESTPRACT-00022")
}