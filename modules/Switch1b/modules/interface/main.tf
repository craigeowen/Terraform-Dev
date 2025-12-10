terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

#resource "nxos_physical_interface" "int-e1_1-switch1b" {
#  provider = nxos.switch1b
#  interface_id             = "eth1/1"
#  admin_state              = "up"
#  description              = "###Agg01 - e1/1 - vpc peer-keepalive ###"
#  layer                    = "Layer3"
#}

resource "nxos_physical_interface" "int-e1_6-switch1b" {
  provider = nxos.switch1b
  interface_id             = "eth1/6"
  access_vlan              = "vlan-1100"
  layer                   = "Layer2"
  mode                    = "access"
  mtu                      = 1500
  admin_state             = "up"
}