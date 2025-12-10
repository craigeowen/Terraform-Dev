terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

resource "nxos_bridge_domain" "vlan1060-switch1a" {
  provider     = nxos.switch1a
  fabric_encap = "vlan-1060"
  name         = "vlan-1060"
}

resource "nxos_bridge_domain" "vlan1100-switch1a" {
  provider     = nxos.switch1a
  fabric_encap = "vlan-1100"
  name         = "vlan-1100"
}