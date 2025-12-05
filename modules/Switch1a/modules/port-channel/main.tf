terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

resource "nxos_port_channel_interface_member" "po-member-switch1a" {
  provider = nxos.switch1a
  interface_id = "po4"
  interface_dn = "sys/intf/phys-[eth1/1]"
  force        = true
}

resource "nxos_port_channel_interface" "po4-switch1a" {
  provider             = nxos.switch1a
  interface_id          = "po4"
  port_channel_mode     = "active"
  minimum_links         = 1
  admin_state           = "up"
  description           = "### vPC peer-keepalive ###"
  layer                 = "Layer3" 
  mtu                   = 9216
}

resource "nxos_port_channel_interface_vrf" "po-vrf-switch1a" {
  provider = nxos.switch1a 
  interface_id = "po4"
  vrf_dn       = "sys/inst-vpc"
}

#resource "nxos_subinterface" "po4_3210-switch1a" {
#  provider             = nxos.switch1a
#  interface_id          = "po4.3210"
#  admin_state           = "up"
#  description           = "### PO4 Sub-Int ###" 
#  encap                 = "vlan-1060"
#  mtu                   = 9216
#}

#resource "nxos_subinterface_vrf" "po4_3210_vrf-switch1a" {
#  provider             = nxos.switch1a
#  interface_id = "po4.3210"
#  vrf_dn       = "sys/inst-vpc"
#}