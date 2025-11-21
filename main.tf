terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

variable "switch_hostname-sw1a" {
  type    = string
  default = "Switch-1A"
}     
variable "switch_hostname-sw1b" {
  type    = string
  default = "Switch-1B"
} 



################## HOSTNAME ###############
resource "nxos_system" "hostname-switch1a" {
  provider = nxos.switch1a
  name = "${var.switch_hostname-sw1a}"
}
resource "nxos_system" "hostname-switch1b" {
  provider = nxos.switch1b
  name = "${var.switch_hostname-sw1b}"
}