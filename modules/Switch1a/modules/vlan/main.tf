terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

resource "nxos_bridge_domain" "vlan1060-switch1a" {
  provider     = nxos.switch1a
  fabric_encap = "vlan-1060"
  name         = "vlan-1060"
}

resource "nxos_bridge_domain" "vlan1100-switch1a" {
  provider     = nxos.switch1a
  fabric_encap = "vlan-1100"
  name         = "vlan-1100"
}

resource "nxos_feature_vn_segment" "feature-vn-seg-switch1a" {
 provider = nxos.switch1a
  admin_state = "enabled"
}

resource "nxos_rest" "test-vlan-switch1a" {
  provider = nxos.switch1a
  dn = "sys/bd/bd-[vlan-20]"
  class_name = "l2BD"
  content = {
    "name": "vlan-20",
     "accEncap" = "vlan-20",
    #"fabricEncap": "vlan-20",
    #"rn": "bd-[vlan-20]",
     "status": "created,modified"
  }
}   

resource "nxos_rest" "test-vrf-switch1a" {
  provider = nxos.switch1a
  dn = "sys/inst-[TEST-VRF-1]"
  class_name = "l3Inst"
  content = {
    "name": "TEST-VRF-1",

  }
} 

resource "nxos_rest" "test-motd-switch1a" {
  provider = nxos.switch1a
  dn = "sys/userext/preloginbanner"
  class_name = "aaaPreLoginBanner"
  content = {
    "delimiter": "^",
    "message": "\n********************\n* Configured by TF *\n********************\n"

  }
} 

resource "nxos_rest" "test-postloginbanner-switch1a" {
  provider = nxos.switch1a
  dn = "sys/userext/postloginbanner"
  class_name = "aaaPostLoginBanner"
  content = {
    "delimiter": "^",
    "message": "\n********************\n* This device MUST ONLY be configured using Teffaform *\n********************\n"

  }
} 