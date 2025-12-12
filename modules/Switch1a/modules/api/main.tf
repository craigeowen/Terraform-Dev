terraform {
  required_providers {
    nxos = {
      source = "CiscoDevNet/nxos"
    }
  }
}

##### No IP Domain Lookup ####
resource "nxos_rest" "no-ip-domain-lookup-switch1a" {
  provider = nxos.switch1a
  dn = "sys/dns"
  class_name = "dnsEntity"
  content = {
    "adminSt": "disabled"
  }
}

##### IP Domain Name ####
resource "nxos_rest" "ip-domain-switch1a" {
  provider = nxos.switch1a
  dn = "sys/dns/prof-[default]/dom"
  class_name = "dnsDom"
  content = {
    "name": "homeoffice.gov.uk"
  }
}

##### username Admin ####
resource "nxos_rest" "username-admin-switch1a" {
  provider = nxos.switch1a
  dn = "sys/userext/user-[admin]"
  class_name = "aaaUser"
  content = {
    "allowExpired": "no",
    "pwd": "Cisco12345",
    "pwdEncryptType": "0"
    
  }
}
resource "nxos_rest" "userrole-admin-switch1a" {
  provider = nxos.switch1a
  dn = "sys/userext/user-[admin]/userdomain-[all]/role-[network-admin]"
  class_name = "aaaUserRole"
  content = {

  }
}


##### username Solarwindsv3min ####
resource "nxos_rest" "username-solarwindsv3-switch1a" {
  provider = nxos.switch1a
  dn = "sys/userext/user-[solarwindsv3]"
  class_name = "aaaUser"
  content = {
    "allowExpired": "no",
    "pwd": "Cisco12345",
    "pwdEncryptType": "0"
    
  }
}
resource "nxos_rest" "userrole-solarwindsv3-switch1a" {
  provider = nxos.switch1a
  dn = "sys/userext/user-[solarwindsv3]/userdomain-[all]/role-[network-operator]"
  class_name = "aaaUserRole"
  content = {

  }
}

