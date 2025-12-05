
variable "three_octet" {
    type = string
#    default = "11.11.11"

}

variable "vrf-VRF1" {
    type = string
    default = "VRF1"
}

variable "vrf-VRF2" {
    type = string
    default = "VRF2"
}

variable "vrf-vpc" {
    type = string
    default = "vpc"
}

####################################################
variable "loopbacks-xxx" {
    type = list(object({
        interface_id = string
        admin_state  = string
        description  = string
    }))
}

