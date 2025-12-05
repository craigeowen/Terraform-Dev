terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

resource "nxos_physical_interface" "int-e1_1-switch1a" {
  provider = nxos.switch1a
  interface_id             = "eth1/1"
#  admin_state              = "up"
  description              = "###Agg01 - e1/1 - vpc peer-keepalive ###"
#  layer                    = "Layer3"
}

