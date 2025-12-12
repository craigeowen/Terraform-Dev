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

resource "nxos_ipv4_interface" "ipv4-int-lo101-switch1a" {
  provider = nxos.switch1a
  vrf          = "VRF1"
  interface_id = "lo101"
}

resource "nxos_ipv4_interface_address" "int-ipv4-address-lo101-switch1a" {
  provider = nxos.switch1a
  vrf          = "VRF1"
  interface_id = "lo101"
  address      = "10.24.1.252/32"
}