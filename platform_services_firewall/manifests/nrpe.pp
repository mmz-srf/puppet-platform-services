class platform_services_firewall::nrpe {
  firewall{'012 accept nrpe':
    proto => 'tcp',
    source => "${network_primary_ip}/${netmask_eth0}",
    dport => 5666,
    action => 'accept',
  }
}
