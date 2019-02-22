class platform_services_network {
  augeas{'sysconfig/network hostname':
    changes => "set /files/etc/sysconfig/network/HOSTNAME $fqdn",
  }

  # leave physical machines, they may use bonding!
  unless $::virtual == 'physical' or $::network_primary_ip == $mpc_network_front {
    if is_mac_address($::macaddress_eth0) {
      class{'::platform_services_network::serv':
        stage => pre,
      }
    }
    if is_mac_address($::macaddress_eth1) {
      class{'::platform_services_network::stor':
        stage => pre,
      }
    }
    if is_mac_address($::macaddress_eth2) {
      class{'::platform_services_network::sync':
        stage => pre,
      }
    }
  }
}
