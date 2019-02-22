class platform_services (
  $manage_front_ips = false,
  $front_ip_mappings = {
    'puppet' => {
      '01' => '13',
      '1'  => '13',
    },
    'dns' => {
      '01' => '14',
      '02' => '15',
    },
    'monitor' => {
      '01' => '16',
    },
    'log' => {
      '01' => '17',
    },
    'patch' => {
      '01' => '18',
    },
    'puppetserver' => {
      '1' => '10',
    },
  },
  $networks_netmask = 24,
) {
  $node_role = regsubst($::hostname, '^(.*)-\d+$', '\1')
  $node_nr = regsubst($::hostname, '^.*-(\d+)$', '\1') ? {
    /^\d+$/ => "$0",
    default => '1',
  }

  if has_key($front_ip_mappings, $node_role) {
    $front_ip_last_octets = $front_ip_mappings[$node_role]
  } else {
    $front_ip_last_octets = {}
  }

  ::platform_services::validate_var{[
    'lsbmajdistrelease',
    'mpc_zone',
    'mpc_project',
    'mpc_bu',
    'mpc_network_front',
  ]:}
  stage{'pre':
    before => Stage['main'],
  }
}
