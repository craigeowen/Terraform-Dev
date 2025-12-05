
variable "switch_hostname-sw1b" {
  type    = string
  default = "test-Switch-2200A"
}

variable "three_octet" {}

variable "four_octet_lo123" {
    type = string
    default = "2"
}

variable "four_octet_lo33" {
    type = string
    default = "12"
}

variable "vrf-VRF1" {}
variable "vrf-VRF2" {}
variable "vrf-vpc" {}

####################################################
variable "loopbacks-xxx" {
    type = list(object({
        interface_id = string
        admin_state  = string
        description  = string
    }))
}
