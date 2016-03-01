class platform_services_dns::server(
  $port_forwarding_vm_guest_ip = undef,
) {
  require platform_services_dns

  # fail if interfaces are not available
  unless (is_mac_address($::platform_services_dns::macaddress_serv) and is_mac_address($::platform_services_dns::macaddress_sync) and is_mac_address($platform_services_dns::macaddress_stor)) {
    fail("dns server must have all interfaces available")
  }

  if is_ip_address($port_forwarding_vm_guest_ip) {
    $vm_guest_ip = $port_forwarding_vm_guest_ip
  }

  # don't do anything if interfaces have no ips (also don't fail)
  if (is_ip_address($::platform_services_dns::ipaddress_serv) and is_ip_address($::platform_services_dns::ipaddress_sync) and is_ip_address($::platform_services_dns::ipaddress_stor)) {
    include ::platform_services
    include ::platform_services_dns::collector
    include ::platform_services_firewall::dns
    include ::dns

    class{'::platform_services::front_ip':
      ports => 53,
    } ->
    platform_services_cloudstack::port_forwarding{'53/udp':
      front_ip => $::platform_services::front_ip::ip,
      port => 53,
      protocol => 'udp',
      vm_guest_ip => $port_forwarding_vm_guest_ip,
    }
    
    class{'::platform_services_resolvconf::nameserver':
      front_ip    => $::platform_services::front_ip::ip,
      internal_ip => $port_forwarding_vm_guest_ip,
    }

    platform_services_dns::server::zone{
      "${::mpc_zone}.serv.${::mpc_project}.${::mpc_bu}.mpc":
        nsip => $::platform_services_dns::ipaddress_serv;
      "${::mpc_zone}.sync.${::mpc_project}.${::mpc_bu}.mpc":
        nsip => $::platform_services_dns::ipaddress_sync;
      "${::mpc_zone}.stor.${::mpc_project}.${::mpc_bu}.mpc":
        nsip => $::platform_services_dns::ipaddress_stor;
    }

    platform_services_dns::server::zone{
      "${::mpc_zone}.${::mpc_project}.${::mpc_bu}.mpc":
        nsip => $::platform_services::front_ip::ip,
        rdns_networks => $::mpc_network_front,
    }
  } else {
    warning("dns server must have all interfaces up and running")
  }
}
