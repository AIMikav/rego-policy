package ocp.deprecated.ocp4_3.buildconfig_jenkinspipeline_strategy

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.api_version) == "build.openshift.io/v1"
  lower(konstraint_core.kind) == "buildconfig"

  konstraint_core.resource.spec.strategy.jenkinsPipelineStrategy

  msg := konstraint_core.format_with_id(sprintf("%s/%s: 'spec.strategy.jenkinsPipelineStrategy' is deprecated. Use Jenkinsfiles directly on Jenkins or OpenShift Pipelines instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.3-00001")
}