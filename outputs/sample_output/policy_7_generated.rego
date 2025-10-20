package policy

deny contains msg if {
object := input.input.review.object
has_invalid_label(object.metadata.labels)
msg := {
"message": "Label key is not consistent. Label keys should be qualified by 'app.kubernetes.io' or 'company.com'.",
"severity": "violation",
}
}

has_invalid_label(labels) if {
some key, value in labels
not startswith(key, "app.kubernetes.io/")
not startswith(key, "company.com/")
}
