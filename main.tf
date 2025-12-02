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

####################################################
     
resource "nxos_loopback_interface" "loxxx-switch1a" {
  provider = nxos.switch1a
  for_each = { for lb in var.loopbacks-xxx : lb.interface_id => lb }
  interface_id = each.value.interface_id
  admin_state  = each.value.admin_state
  description  = each.value.description   
}