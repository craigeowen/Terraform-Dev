terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

resource "nxos_ipv4_interface" "ipv4-int-po4-switch1b" {
  provider = nxos.switch1b
  vrf          = "vpc"
  interface_id = "po4"
}

resource "nxos_ipv4_interface_address" "int-ipv4-address-switch1b" {
  provider = nxos.switch1b
  vrf          = "vpc"
  interface_id = "po4"
  address      = "1.1.1.2/30"
}