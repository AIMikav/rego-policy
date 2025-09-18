package ocp.bestpractices.pod_antiaffinity_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00026")

  pod_spec := openshift.pod.spec
  konstraint_core.missing_field(pod_spec.affinity, "podAntiAffinity")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: spec.affinity.podAntiAffinity not set. See: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00026")
}