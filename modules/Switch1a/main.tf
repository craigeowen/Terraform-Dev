terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

################## HOSTNAME ###############
resource "nxos_system" "hostname-switch1a" {
  provider = nxos.switch1a
  name = "${var.switch_hostname-sw1a}"


}

resource "nxos_vrf" "vrf-VRF1-switch1a" {
  provider = nxos.switch1a
  name = "VRF1"
}

#################Interface lo123######################
resource "nxos_loopback_interface" "lo123-switch1a" {
  provider = nxos.switch1a
  interface_id = "lo123"
  admin_state  = "down"
  description = var.three_octet
}

resource "nxos_loopback_interface_vrf" "lo123-switch1a" {
  provider = nxos.switch1a
  interface_id = "lo123"
  vrf_dn = "sys/inst-VRF1"
}

resource "nxos_ipv4_interface" "lo123-switch1a" {
  provider = nxos.switch1a
  vrf          = "VRF1"
  interface_id = "lo123"
}

resource "nxos_ipv4_interface_address" "lo123-switch1a" {
  provider = nxos.switch1a
  vrf          = "VRF1"
  interface_id = "lo123"
  address      = "${var.three_octet}.${var.four_octet}/32"
}

#################Interface leth1/7######################
resource "nxos_physical_interface" "eth1_7-switch1a" {
  provider = nxos.switch1a
  interface_id = "eth1/7"
  admin_state  = "up"
  description  = "My Description"
  layer = "Layer3"
}

resource "nxos_physical_interface_vrf" "eth1_7-switch1a" {
  provider = nxos.switch1a
  interface_id = "eth1/7"
  vrf_dn = "sys/inst-VRF1"
}

resource "nxos_ipv4_interface" "eth1_7-switch1a" {
  provider = nxos.switch1a
  vrf          = "VRF1"
  interface_id = "eth1/7"
}

resource "nxos_ipv4_interface_address" "eth1_7-switch1a" {
  provider = nxos.switch1a
  vrf          = "VRF1"
  interface_id = "eth1/7"
  address      = "24.63.46.49/30"
}