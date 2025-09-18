package ocp.deprecated.ocp4_2.operatorsources_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  contains(lower(konstraint_core.api_version), "operators.coreos.com/v1")
  lower(konstraint_core.kind) == "operatorsource"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: operators.coreos.com/v1 is deprecated.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00005")
}