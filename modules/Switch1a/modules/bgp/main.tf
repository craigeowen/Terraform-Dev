terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}
#####Set up Router BGP #####

resource "nxos_bgp" "router_bgp-switch1a" {
  provider = nxos.switch1a
  admin_state = "enabled"
}

resource "nxos_bgp_instance" "router_bgp_instance-switch1a" {
  provider                = nxos.switch1a
  admin_state             = "enabled"
  asn                     = "65201"
}

resource "nxos_bgp_vrf" "router-bgp-vrf-switch1a" {
  provider = nxos.switch1a
  asn       = "65201"
  name      = "VRF1"
  router_id = "10.24.1.252"
}

##### Add Router BGP Address Family #####
resource "nxos_bgp_address_family" "router-bgp-AF-switch1a" {
  provider = nxos.switch1a
  asn                                    = "65201"
  vrf                                    = "VRF1"
  address_family                         = "ipv4-ucast"
  }
  resource "nxos_bgp_advertised_prefix" "router-bgp-prefix-switch1a" {
  provider = nxos.switch1a
  asn            = "65201"
  vrf            = "VRF1"
  address_family = "ipv4-ucast"
  prefix         = "10.24.1.252/32"
}

 ##### Add Peer Template #####
 resource "nxos_bgp_peer_template" "pt-ebgp-baseline-switch1a" {
  provider = nxos.switch1a
  asn              = "65201"
  template_name    = "EBGP-BASELINE"
  remote_asn       = "65200"
}
resource "nxos_bgp_peer_template_address_family" "pt-ebgp-baseline-AF-switch1a" {
  provider = nxos.switch1a
  asn                     = "65201"
  template_name           = "EBGP-BASELINE"
  address_family          = "ipv4-ucast"
  send_community_extended = "enabled"
  send_community_standard = "enabled"
}
 resource "nxos_bgp_peer_template" "pt-ibgp-baseline-switch1a" {
  provider = nxos.switch1a
  asn              = "65201"
  template_name    = "ibgp-baseline"
  remote_asn       = "65201"
}
resource "nxos_bgp_peer_template_address_family" "pt-ibgp-baseline-AF-switch1a" {
  provider = nxos.switch1a
  asn                     = "65201"
  template_name           = "ibgp-baseline"
  address_family          = "ipv4-ucast"
  send_community_extended = "enabled"
  send_community_standard = "enabled"
}

##### Add BGP Peer #####
resource "nxos_bgp_peer" "bgp-peer-AGG02-switch1a" {
  provider = nxos.switch1a
  asn               = "65201"
  vrf               = "VRF1"
  address           = "10.24.1.253"
  description       = "TF-BGP-TO-AGG02"
  peer_template     = "ibgp-baseline"
  source_interface  = "lo0"
}
resource "nxos_bgp_peer" "bgp-peer-EDG01-switch1a" {
  provider = nxos.switch1a
  asn               = "65201"
  vrf               = "VRF1"
  address           = "10.24.1.250"
  description       = "TF-BGP-TO-EDG01"
  peer_template     = "ibgp-baseline"
  source_interface  = "lo0"
}
resource "nxos_bgp_peer" "bgp-peer-EDG02-switch1a" {
  provider = nxos.switch1a
  asn               = "65201"
  vrf               = "VRF1"
  address           = "10.24.1.251"
  description       = "TF-BGP-TO-EDG02"
  peer_template     = "ibgp-baseline"
  source_interface  = "lo0"
}

##### Add BGP with API #####
resource "nxos_rest" "test-bgp-pt-peercont-switch1a" {
  provider = nxos.switch1a
  dn = "sys/bgp/inst/dom-[default]/peercont-[ibgp-baseline]"
  class_name = "bgpPeerCont"
  content = {
    "holdIntvl": "30",
    "kaIntvl": "10",
    #"password": "password1234"

  }
}

resource "nxos_rest" "test-bgp-pt-peeraf-switch1a" {
  provider = nxos.switch1a
  dn = "sys/bgp/inst/dom-[default]/peercont-[ibgp-baseline]/af-[ipv4-ucast]"
  class_name = "bgpPeerAf"
  content = {
    "ctrl": "nh-self,rr-client",
    "softReconfigBackup": "inbound"
  }
}

resource "nxos_rest" "test-bgp-peeraf-switch1a" {
  provider = nxos.switch1a
  dn = "sys/bgp/inst/dom-[VRF1]/peer-[10.24.1.253]/af-[ipv4-ucast]"
  class_name = "bgpPeerAf"
  content = {
    #"ctrl": ""
    "inheritContPeerPolicyCtrl": "rr-client"
  }
}

resource "nxos_rest" "test-bgp-pt-EBGP-peercont-switch1a" {
  provider = nxos.switch1a
  dn = "sys/bgp/inst/dom-[default]/peercont-[EBGP-BASELINE]"
  class_name = "bgpPeerCont"
  content = {
    "holdIntvl": "30",
    "kaIntvl": "10",
    "ctrl": "bfd"
    #"password": "password123"

  }
}
resource "nxos_rest" "test-bgp-pt-EBGPpeeraf-switch1a" {
  provider = nxos.switch1a
  dn = "sys/bgp/inst/dom-[default]/peercont-[EBGP-BASELINE]/af-[ipv4-ucast]"
  class_name = "bgpPeerAf"
  content = {
     "softReconfigBackup": "inbound"
  }
}

##### Add Address Family #####
#resource "nxos_bgp_vrf_address_family" "ibgp-vrf-af-switch1a" {
#  provider = nxos.switch1a
#  asn                     = "65201"
#  name                    = "VRF1"
#  address                 = "10.24.1.253"
#  address_family          = "ipv4-ucast"
#}
