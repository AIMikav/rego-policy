package ocp.bestpractices.container_resources_limits_cpu_set

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00010")
  some container in openshift.containers

  container.resources.limits.cpu

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has cpu limits (%d). It is not recommended to limit cpu. See: https://www.reddit.com/r/kubernetes/comments/all1vg/on_kubernetes_cpu_limits", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.limits.cpu]), "RHCOP-OCP_BESTPRACT-00010")
}