class platform_services_haproxy::server(
  $high_available = false,
  $site_classes   = undef
) {
  class{'::haproxy':}
  if $high_available {
    sysctl::value{'net.ipv4.ip_nonlocal_bind': value => '1'}
    include keepalived
    ensure_resource('package', 'libipset3', {ensure => installed})
    keepalived::vrrp_script{'haproxy':
      script => '/usr/bin/killall -0 haproxy', 
      weight => 51,
    }
  }
  if $site_classes {
    class{$site_classes:}
  }
}

