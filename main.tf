terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

     
#variable "switch_hostname-sw1b" {
#  type    = string
#  default = "Switch-1B"
#} 

################## MODULE ###############
module "config-SW1a" {
  source = "./modules/Switch1a"
   ###take the Top Level subnet and use in module###
  three_octet = var.three_octet
}

module "config-SW1b" {
  source = "./modules/Switch1b"
   ###take the Top Level subnet and use in module###
  three_octet = var.three_octet
}

################## HOSTNAME ###############
#resource "nxos_system" "hostname-switch1a" {
#  provider = nxos.switch1a
#  name = "${var.switch_hostname-sw1a}"
#}
#resource "nxos_system" "hostname-switch1b" {
#  provider = nxos.switch1b
#  name = "${var.switch_hostname-sw1b}"
#}