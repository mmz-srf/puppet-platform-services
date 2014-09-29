define platform_services_haproxy::service(
  $ipaddress,
  $ports,
  $options = {},
  $virtual_router_id = undef,
  $preferred_instance  = undef
) {

  if $::platform_services_haproxy::server::high_available {
    $network_netmask = $::platform_services::networks_netmask
    if ($virtual_router_id and !defined(Keepalived::Instance[$virtual_router_id]) ){

      $base_priority = 251 - $::platform_services::node_nr * 50

      if ( $::platform_services::node_nr == $preferred_instance ) {
        $priority = 254
      } else {
      # base_priority und undef
        $priority = $base_priority
      }

      if( $priority > 254 or $priority < 1 ){
        fail('VRPP priority must be in range 1 - 254')
      }

      keepalived::instance{$virtual_router_id:
        interface    => 'eth0',
        virtual_ips  => [ "$ipaddress/$network_netmask" ],
        state        => 'BACKUP',
        priority     => $priority,
        track_script => [ "haproxy" ],
        auth_type    => "PASS",
        auth_pass    => "635178udDK1AQ123",
      }
    }
    
    haproxy::listen{$name:
      ipaddress => $ipaddress,
      ports     => $ports,
      options   => $options,
    }
  }
  else
  {
    # TODO: move this somewhere else...
    $aliasname  = ipv4tohex($ipaddress)
    case $::mpc_bu {
      'srf': {
        network_config { "eth0:${aliasname}":
          ensure    => 'present',
          method    => 'static',
          ipaddress => $ipaddress,
          netmask   => '255.255.252.0',
          onboot    => 'true',
        }->
        exec {"reload interface eth0:${aliasname}":
          command => "/sbin/ifdown eth0:${aliasname};/sbin/ifup eth0:${aliasname}",
          unless  => "ifconfig | grep -q '^eth0:${aliasname} '",
        }->
        haproxy::listen{$name:
          ipaddress => $ipaddress,
          ports     => $ports,
          options   => $options,
        }
      }
      default: {
        network_config { "eth0:$shortname":
          ensure    => 'present',
          method    => 'static',
          ipaddress => $ipaddress,
          netmask   => '255.255.255.0',
          onboot    => 'true',
        }->
        exec {"reload interface eth0:$shortname":
          command => "/sbin/ifdown eth0:$shortname;/sbin/ifup eth0:$shortname",
          unless => "ifconfig | grep -q '^eth0:${shortname} '",
        }->
        haproxy::listen{$name:
          ipaddress => $ipaddress,
          ports     => $ports,
          options   => $options,
        }
      }
    }
  }

  # Match only first haproxy on Vagrant and all UE's 
  if $hostname =~ /^haproxy(-zrh-01|-bie-01|-1)?$/ {
    platform_services_dns::member::zone{"${name}.${::mpc_zone}.${::mpc_project}.${::mpc_bu}.mpc":
      domain    => "${::mpc_zone}.${::mpc_project}.${::mpc_bu}.mpc",
      hostname  => $name,
      ipaddress => $ipaddress,
    }
  }
}
