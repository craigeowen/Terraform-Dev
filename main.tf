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
  vrf-vpc = var.vrf-vpc
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
  vrf-vpc = var.vrf-vpc
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


##### Return Data from Switches #####
data "nxos_system" "system-info-switch1a" {
  provider = nxos.switch1a
}
output "hostname" {
  value = data.nxos_system.system-info-switch1a.name
}

data "nxos_loopback_interface" "nxos-lo101-switch1a" {
  provider = nxos.switch1a
  interface_id = "lo101"
}
output "lo101_admin_state-switch1a" {
  value = data.nxos_loopback_interface.nxos-lo101-switch1a.admin_state
} 
output "lo101_description-switch1a" {
  value = data.nxos_loopback_interface.nxos-lo101-switch1a.description
}

data "nxos_bgp_peer" "bgp_peer-info-switch1a" {
  provider = nxos.switch1a
  asn               = "65201"
  vrf               = "VRF1"
  address           = "10.24.1.253"
}
output "nxos_bgp" {
  value = data.nxos_bgp_peer.bgp_peer-info-switch1a.description
}