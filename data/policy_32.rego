package ocp.deprecated.ocp3_11.projectrequest_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.api_version) == "v1"
  lower(konstraint_core.kind) == "projectrequest"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for ProjectRequest is no longer served by default, use project.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00004")
}