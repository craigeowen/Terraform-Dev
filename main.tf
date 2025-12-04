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
  loopbacks-xxx = [
   {
            interface_id = var.loopbacks-xxx[0].interface_id
            admin_state  = var.loopbacks-xxx[0].admin_state
            description  = var.loopbacks-xxx[0].description
        },
    {       interface_id = var.loopbacks-xxx[1].interface_id
            admin_state  = var.loopbacks-xxx[1].admin_state
            description  = var.loopbacks-xxx[1].description
        }   
]
} 

module "config-SW1b" {
  source = "./modules/Switch1b"
   ###take the Top Level variable and use in module###
  three_octet = var.three_octet
  vrf-VRF1 = var.vrf-VRF1
  vrf-VRF2 = var.vrf-VRF2
  loopbacks-xxx = [
   {
            interface_id = var.loopbacks-xxx[0].interface_id
            admin_state  = var.loopbacks-xxx[0].admin_state
            description  = var.loopbacks-xxx[0].description
        },
    {       interface_id = var.loopbacks-xxx[1].interface_id
            admin_state  = var.loopbacks-xxx[1].admin_state
            description  = var.loopbacks-xxx[1].description
        }    
]
}   
