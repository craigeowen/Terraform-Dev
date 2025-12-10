terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

module "config-SW1b-pc" {
  source = "./modules/port-channel"
   ###take the Top Level variable and use in module### 
}
module "config-SW1b-vlan" {
  source = "./modules/vlan"
   ###take the Top Level variable and use in module### 
}
module "config-SW1b-interface" {
  source = "./modules/interface"
   ###take the Top Level variable and use in module### 
}
module "config-SW1b-ipv4_address" {
  source = "./modules/ipv4_address"
   ###take the Top Level variable and use in module### 
}
module "config-SW1b-VPC" {
  source = "./modules/VPC"
   ###take the Top Level variable and use in module### 
}

#####Enable Feature - VPC and LACP#####
resource "nxos_feature_vpc" "feature_vpc-switch1b" {
  provider = nxos.switch1b
  admin_state = "enabled"
}
resource "nxos_feature_lacp" "feature_lacp-switch1b" {
  provider = nxos.switch1b
  admin_state = "enabled"
}

################## HOSTNAME ###############
resource "nxos_system" "hostname-switch1b" {
  provider = nxos.switch1b
  name = "${var.switch_hostname-sw1b}"
}

################## VRF ###############
resource "nxos_vrf" "vrf-VFR1-switch1b" {
  provider = nxos.switch1b
  name = var.vrf-VRF1
}
resource "nxos_vrf" "vrf-VFR2-switch1b" {
  provider = nxos.switch1b
  name = var.vrf-VRF2
}
resource "nxos_vrf" "vrf-vpc-switch1b" {
  provider = nxos.switch1b
  name = var.vrf-vpc
}

#################Interface lo123######################
resource "nxos_loopback_interface" "lo123-switch1b" {
  provider = nxos.switch1b
  interface_id = "lo123"
  admin_state  = "down"
  description = var.three_octet
}

resource "nxos_loopback_interface_vrf" "lo123-switch1b" {
  provider = nxos.switch1b
  interface_id = "lo123"
  vrf_dn = "sys/inst-${var.vrf-VRF1}"
}

resource "nxos_ipv4_interface" "lo123-switch1b" {
  provider = nxos.switch1b
  vrf          = "${var.vrf-VRF1}"
  interface_id = "lo123"
}

resource "nxos_ipv4_interface_address" "lo123-switch1b" {
  provider = nxos.switch1b
  vrf          = "${var.vrf-VRF1}"
  interface_id = "lo123"
  address      = "${var.three_octet}.${var.four_octet_lo123}/32"
}

#################Interface leth1/7######################
resource "nxos_physical_interface" "eth1_7-switch1b" {
  provider = nxos.switch1b
  interface_id = "eth1/7"
  admin_state  = "up"
  description  = "My Description-switch1b to switch1a"
  layer = "Layer3"
}

resource "nxos_physical_interface_vrf" "eth1_7-switch1b" {
  provider = nxos.switch1b
  interface_id = "eth1/7"
  vrf_dn = "sys/inst-VRF1"
}

resource "nxos_ipv4_interface" "eth1_7-switch1b" {
  provider = nxos.switch1b
  vrf          = "VRF1"
  interface_id = "eth1/7"
}

resource "nxos_ipv4_interface_address" "eth1_7-switch1b" {
  provider = nxos.switch1b
  vrf          = "VRF1"
  interface_id = "eth1/7"
  address      = "24.63.46.50/30"
}

#################Interface lo33######################
resource "nxos_loopback_interface" "lo33-switch1b" {
  provider = nxos.switch1b
  interface_id = "lo33"
  admin_state  = "down"
  description = var.three_octet
}

resource "nxos_loopback_interface_vrf" "lo33-switch1b" {
  provider = nxos.switch1b
  interface_id = "lo33"
  vrf_dn = "sys/inst-${var.vrf-VRF2}"
}

resource "nxos_ipv4_interface" "lo33-switch1b" {
  provider = nxos.switch1b
  vrf          = "${var.vrf-VRF2}"
  interface_id = "lo33"
}

resource "nxos_ipv4_interface_address" "lo33-switch1b" {
  provider = nxos.switch1b
  vrf          = "${var.vrf-VRF2}"
  interface_id = "lo33"
  address      = "${var.three_octet}.${var.four_octet_lo33}/32"
}

####################################################
     
resource "nxos_loopback_interface" "loxxx-switch1b" {
  provider = nxos.switch1b
  for_each = { for lb in var.loopbacks-xxx : lb.interface_id => lb }
  interface_id = each.value.interface_id
  admin_state  = each.value.admin_state
  description  = each.value.description   
}

#####
#####Config Save#####
#####
resource "nxos_save_config" "save-switch1b" {
  provider = nxos.switch1b
}