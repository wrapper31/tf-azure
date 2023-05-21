locals {
  # Default US EAST 2
  # firewallIp  ="10.233.16.68"
  # firewallIp = ({
  # "${var.env != "p" && var.location_prefix == "musce1"}" = "10.235.0.68"
  # "${var.env != "p" && var.location_prefix != "musce1"}" = "10.233.0.68"
  # "${var.location_prefix == "musce1"}" = "10.235.16.68"
  # "${var.location_prefix != "musce1"}" = "10.233.16.68"
  # "${var.location_prefix == "musea2"}" = "10.233.16.68"
  #  } )
  pubnet_access_enabled = true
  pvtnet_access_enabled = true

  tags = {
    "GM ASMS No"              = var.asms
    "GM Business Criticality" = "Critical"
  }
}
