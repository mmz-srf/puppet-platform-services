define platform_services_dns::server::zone(
  $nsip,
  $rdns_networks = $nsip,
  $nameservers = [ "${::hostname}.${::mpc_zone}.${::mpc_project}.${::mpc_bu}.mpc", "ns1.stxt.media.int", "ns2.stxt.media.int" ]
) {
  dns::zone{$name:
    soa => "${::hostname}.${::mpc_zone}.${::mpc_project}.${::mpc_bu}.mpc",
    soa_email => "admin.$name",
    nameservers => $nameservers,
    zone_ttl => 60,
    zone_minimum => 60,
  }
  $rdns_zones = ip_to_arpa($rdns_networks, $::platform_services::networks_netmask)
  dns::zone{$rdns_zones:
    soa => "${::hostname}.${::mpc_zone}.${::mpc_project}.${::mpc_bu}.mpc",
    soa_email => "admin.$name",
    nameservers => $nameservers,
    zone_ttl => 60,
    zone_minimum => 60,
  }
}
