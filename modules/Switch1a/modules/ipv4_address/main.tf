terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

resource "nxos_ipv4_interface" "ipv4-int-po4-switch1a" {
  provider = nxos.switch1a
  vrf          = "vpc"
  interface_id = "po4"
}

resource "nxos_ipv4_interface_address" "int-ipv4-address-switch1a" {
  provider = nxos.switch1a
  vrf          = "vpc"
  interface_id = "po4"
  address      = "1.1.1.1/30"
}