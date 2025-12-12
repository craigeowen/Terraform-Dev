terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

#resource "nxos_physical_interface" "int-e1_1-switch1a" {
#  provider = nxos.switch1a
#  interface_id             = "eth1/1"
#  admin_state              = "up"
#  description              = "###Agg01 - e1/1 - vpc peer-keepalive ###"
#  layer                    = "Layer3"
#}

#resource "nxos_physical_interface" "int-e1_5-switch1a" {
#  provider = nxos.switch1a
#  interface_id             = "eth1/5"
#  mtu                      = 1500
#}

resource "nxos_physical_interface" "int-e1_6-switch1a" {
  provider = nxos.switch1a
  interface_id             = "eth1/6"
  access_vlan              = "vlan-1100"
  layer                   = "Layer2"
  mode                    = "access"
  mtu                      = 1500
  admin_state             = "up"
}

resource "nxos_loopback_interface" "int-lo101-switch1a" {
  provider = nxos.switch1a
  interface_id = "lo101"
  admin_state = "up"
  description = "### Loopback 101 ###"
}
resource "nxos_loopback_interface_vrf" "int-lo101-VRF1-switch1a" {
  provider = nxos.switch1a
  interface_id = "lo101"
  vrf_dn       = "sys/inst-VRF1"
}