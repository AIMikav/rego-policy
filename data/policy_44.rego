package ocp.deprecated.ocp4_2.servicecatalog_v1beta1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  contains(lower(konstraint_core.api_version), "servicecatalog.k8s.io/v1beta1")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: servicecatalog.k8s.io/v1beta1 is deprecated.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00007")
}