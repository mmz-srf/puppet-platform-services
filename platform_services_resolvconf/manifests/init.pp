class platform_services_resolvconf(
    $timeout = 3,
){
  if $::virtual != 'docker' {
    resolvconf::search{"${::mpc_zone}.serv.${::mpc_project}.${::mpc_bu}.mpc":}
    resolvconf::search{"${::mpc_zone}.${::mpc_project}.${::mpc_bu}.mpc":}

    resolvconf::option {'timeout':
      value => $timeout,
    }

    if $::mpc_network_front == $::network_primary_ip {
      resolvconf::domain{"${::mpc_zone}.${::mpc_project}.${::mpc_bu}.mpc":}
      Resolvconf::Nameserver <<|tag=='front'|>>
    } else {
      resolvconf::domain{"${::mpc_zone}.serv.${::mpc_project}.${::mpc_bu}.mpc":}
      Resolvconf::Nameserver <<|tag=='internal'|>>
      $default_nameserver = regsubst(baseip(), '^(\d+)\.(\d+)\.(\d+)\.(\d+)$',  '\1.\2.\3.1')
      if $default_nameserver != $::ipaddress and
        !defined(Resolvconf::Nameserver[$default_nameserver]) {
        resolvconf::nameserver{$default_nameserver:
          priority => 10,
          tag => 'internal',
        }
      }
    }

  }
}
