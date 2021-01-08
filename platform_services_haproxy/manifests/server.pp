class platform_services_haproxy::server(
  $high_available = false,
  $site_classes   = undef,
) {
  class{'::haproxy':}
  if $high_available {
    sysctl::value{'net.ipv4.ip_nonlocal_bind': value => '1'}
    include keepalived

    if $::lsbdistcodename == 'buster' {
      $libipset_package = 'libipset11'
    } else {
      $libipset_package = 'libipset3'
    }
    ensure_resource('package', $libipset_package, {ensure => installed})

    keepalived::vrrp_script{'haproxy':
      script => '/usr/bin/nice -n -20 pgrep haproxy$',
      weight => 51,
    }
  }
  if $site_classes {
    class{$site_classes:}
  }
}

