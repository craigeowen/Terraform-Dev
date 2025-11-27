terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

     
################## MODULE ###############
module "config-SW1a" {
  source = "./modules/Switch1a"
   ###take the Top Level variable and use in module###
  three_octet = var.three_octet
  vrf-VRF1 = var.vrf-VRF1
  vrf-VRF2 = var.vrf-VRF2
}

module "config-SW1b" {
  source = "./modules/Switch1b"
   ###take the Top Level variable and use in module###
  three_octet = var.three_octet
  vrf-VRF1 = var.vrf-VRF1
  vrf-VRF2 = var.vrf-VRF2
}

