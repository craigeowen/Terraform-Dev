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

resource "nxos_vpc_peerlink" "vpc-peerlink-switch1b" {
  provider = nxos.switch1b
  port_channel_id = "po1"
}

#####VPC Menber Interfaces#####
resource "nxos_vpc_interface" "vpc-int-1_5-switch1b" {
  provider = nxos.switch1b
  vpc_interface_id          = 5
  port_channel_interface_dn = "sys/intf/aggr-[po10]"
}