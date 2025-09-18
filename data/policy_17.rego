package ocp.bestpractices.container_secret_mounted_envs

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00016")
  some container in openshift.containers

  some env in container.env
  env.valueFrom.secretKeyRef

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has a secret '%s' mounted as an environment variable. Secrets are meant to be secret, it is not a good practice to mount them as env vars.", [konstraint_core.kind, konstraint_core.name, container.name, env.valueFrom.secretKeyRef.name]), "RHCOP-OCP_BESTPRACT-00016")
}