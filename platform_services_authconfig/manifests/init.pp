class platform_services_authconfig {

  host{'dirsrv01.stxt.mpc':
    ensure => absent,
    ip     => '10.100.219.85',
  } ~>
  file{'/etc/openldap/certs/cacert.pem':
    source => [
      "puppet:///modules/site_authconfig/cacerts/${::fqdn}/cacert.pem",
      'puppet:///modules/site_authconfig/cacerts/cacert.pem',
      'puppet:///modules/platform_services_authconfig/cacerts/DigiCertHighAssuranceCA-3.pem'
    ],
    owner  => root,
    group  => 0,
    mode   => '0644';
  } ~>
  class{'authconfig':
    mkhomedir      => hiera('mkhomedir', true),
    ldaptls        => hiera('ldaptls', true),
    ldapserver     => hiera('ldapserver', 'ldap-ha.swisstxt.ch'),
    ldaploadcacert => hiera('ldaploadcacert', 'file:///etc/openldap/certs/cacert.pem'),
    sssd_enumerate => hiera('sssd_enumerate', true),
  }
}
