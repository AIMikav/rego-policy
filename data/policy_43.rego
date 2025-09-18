package ocp.deprecated.ocp4_2.osb_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  contains(lower(konstraint_core.api_version), "osb.openshift.io/v1")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: osb.openshift.io/v1 is deprecated.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00006")
}