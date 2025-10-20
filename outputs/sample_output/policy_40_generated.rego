package policy

deny contains msg if {
input.input.review.object.apiVersion == "operators.coreos.com/v1"
input.input.review.object.kind == "CatalogSourceConfig"
msg := {
"message": "CatalogSourceConfigs resources must not use the deprecated 'operators.coreos.com/v1:CatalogSourceConfigs' API.",
"severity": "violation",
}
}
