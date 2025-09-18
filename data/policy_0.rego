package combine.namespace_has_networkpolicy

import future.keywords.in

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  some manifests in input
  some namespace in manifests

  lower(namespace.apiVersion) == "v1"
  lower(namespace.kind) == "namespace"

  not _has_networkpolicy(manifests)

  msg := konstraint_core.format_with_id(sprintf("%s/%s does not have a networking.k8s.io/v1:NetworkPolicy. See: https://docs.openshift.com/container-platform/4.6/networking/network_policy/about-network-policy.html", [namespace.kind, namespace.metadata.name]), "RHCOP-COMBINE-00001")
}

_has_networkpolicy(manifests) {
  some current in manifests

  lower(current.apiVersion) == "networking.k8s.io/v1"
  lower(current.kind) == "networkpolicy"
}