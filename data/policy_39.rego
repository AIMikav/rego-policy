package ocp.deprecated.ocp4_2.automationbroker_v1alpha1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  contains(lower(konstraint_core.api_version), "automationbroker.io/v1alpha1")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: automationbroker.io/v1alpha1 is deprecated.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00002")
}