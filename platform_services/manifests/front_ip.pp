class platform_services::front_ip(
  $ports = [80],
  $front_ip = undef,
) {
  if $front_ip {
    $ip = $front_ip
  } else {
    unless has_key($::platform_services::front_ip_last_octets, $::platform_services::node_nr) {
      fail("must provide front-ip-mapping for ${::platform_services::node_role} node number ${::platform_services::node_nr}")
    }
    $front_ip_last_octet = $::platform_services::front_ip_last_octets[$::platform_services::node_nr]
    $ip = inline_template("<%= @mpc_network_front.sub(/0$/, '') + @front_ip_last_octet %>")
  }

  platform_services_cloudstack::port_forwarding{$ports:
    front_ip => $ip,
  }
  platform_services_dns::member::zone_front{$::hostname:
    front_ip => $ip,
  }
}
