package policy

deny contains msg if {
input.input.review.object.kind == "BuildConfig"
has_deprecated_strategy
msg := {
"message": "BuildConfig uses deprecated jenkinsPipelineStrategy. Use Jenkinsfiles directly on Jenkins or OpenShift Pipelines instead.",
"severity": "violation",
}
}

has_deprecated_strategy if {
input.input.review.object.spec.strategy.type == "JenkinsPipeline"
input.input.review.object.spec.strategy.jenkinsPipelineStrategy != null
}
