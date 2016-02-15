class platform_services_resolvconf::nameserver(
  $front_ip = false,
  $internal_ip = $::ipaddress,
  $default_nameserver = [ "193.218.104.190", "193.218.103.253" ]
){
  case $::mpc_bu {
    'srf': {
      include platform_services

      if $front_ip {
        @@resolvconf::nameserver {$front_ip:
          priority => $::platform_services::node_nr,
          tag => 'front',
        }
      }
      @@resolvconf::nameserver {$internal_ip:
        priority => $::platform_services::node_nr,
        tag => 'internal'
      }
    }
    default: {
      @@resolvconf::nameserver{$default_nameserver:
        priority => 10,
        tag => 'internal',
      }
    }
  }
}
