locals {
  name_prefix             = "${var.asms}-${var.env}-${var.location_prefix}"
  resource_prefix_no_dash = replace(var.resource_prefix, "-", "")
  tags = {
    "GM ASMS No"                       = "213222"
    "GM Business Criticality"          = "Important"
    "GM Strictest Data Classification" = "GM Confidential"
  }
}
