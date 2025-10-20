package policy

deny contains msg if {
buildconfig := input.input.review.object
has_deprecated_field(buildconfig)
msg := {
"message": "BuildConfig exposeDockerSocket deprecated: BuildConfig resources must not use the deprecated 'spec.strategy.customStrategy.exposeDockerSocket' field.",
"severity": "violation"
}
}

has_deprecated_field(buildconfig) if {
buildconfig.spec.strategy.type == "Custom"
buildconfig.spec.strategy.customStrategy.exposeDockerSocket == true
}
