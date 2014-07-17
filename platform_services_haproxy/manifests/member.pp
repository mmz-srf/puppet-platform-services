define platform_services_haproxy::member(
  $service,
  $ports,
  $front_ip = false,
  $options = 'check'
) {
  if $front_ip {
    ensure_resource('platform_services_cloudstack::port_forwarding', $ports, {'front_ip' => $front_ip})
    $ip = $front_ip
  } else {
    $ip = $::ipaddress
  }
  @@haproxy::balancermember{$name:
    listening_service => $service,
    server_names      => $::hostname,
    ipaddresses       => $ip,
    ports             => $ports,
    options           => $options
  }
}
