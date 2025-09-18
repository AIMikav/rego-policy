package ocp.bestpractices.container_java_xmx_set

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00005")
  konstraint_core.labels["redhat-cop.github.com/technology"] == "java"

  some container in openshift.containers
  _container_opts_contains_xmx(container)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00005")
}

_container_opts_contains_xmx(container) {
  some command in container.command
  contains(command, "-Xmx")
}

_container_opts_contains_xmx(container) {
  some arg in container.args
  contains(arg, "-Xmx")
}

_container_opts_contains_xmx(container) {
  some env in container.env
  contains(env.value, "-Xmx")
}