terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

resource "nxos_vpc_instance" "vpc-switch1b" {
  provider = nxos.switch1b   
  admin_state = "enabled"
}

resource "nxos_vpc_domain" "vcp-dom-switch1b" {
  provider = nxos.switch1b
  admin_state                    = "enabled"
  domain_id                      = 101
}

resource "nxos_vpc_keepalive" "vpc-keepalive-switch1b" {
  provider = nxos.switch1b
  destination_ip                     = "1.1.1.1"
  source_ip                          = "1.1.1.2"
  vrf                                = "vpc"
}