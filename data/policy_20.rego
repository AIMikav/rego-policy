package ocp.bestpractices.deploymentconfig_triggers_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_deploymentconfig

  konstraint_core.missing_field(konstraint_core.resource.spec, "triggers")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: has no triggers set. Could you use a k8s native Deployment? See: https://kubernetes.io/docs/concepts/workloads/controllers/deployment", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00019")
}