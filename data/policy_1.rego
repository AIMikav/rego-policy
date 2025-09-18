package combine.namespace_has_resourcequota

import future.keywords.in

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  some manifests in input
  some namespace in manifests

  lower(namespace.apiVersion) == "v1"
  lower(namespace.kind) == "namespace"

  not _has_resourcequota(manifests)

  msg := konstraint_core.format_with_id(sprintf("%s/%s does not have a core/v1:ResourceQuota. See: https://docs.openshift.com/container-platform/4.6/applications/quotas/quotas-setting-per-project.html", [namespace.kind, namespace.metadata.name]), "RHCOP-COMBINE-00002")
}

_has_resourcequota(manifests) {
  some current in manifests

  lower(current.apiVersion) == "v1"
  lower(current.kind) == "resourcequota"
}