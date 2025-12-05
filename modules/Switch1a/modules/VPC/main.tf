terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

resource "nxos_vpc_instance" "vpc-switch1a" {
  provider = nxos.switch1a   
  admin_state = "enabled"
}

resource "nxos_vpc_domain" "vcp-dom-switch1a" {
  provider = nxos.switch1a  
  admin_state                    = "enabled"
  domain_id                      = 101
}

resource "nxos_vpc_keepalive" "vpc-keepalive-switch1a" {
  provider = nxos.switch1a
  destination_ip                     = "1.1.1.2"
  source_ip                          = "1.1.1.1"
  vrf                                = "vpc"
}

resource "nxos_vpc_peerlink" "vpc-peerlink-switch1a" {
  provider = nxos.switch1a
  port_channel_id = "po1"
}