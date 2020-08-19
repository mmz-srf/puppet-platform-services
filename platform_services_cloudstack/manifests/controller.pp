class platform_services_cloudstack::controller {
  $cloudstack_api_key    = lookup('cloudstack_api_key', String, 'first', '')
  $cloudstack_secret_key = lookup('cloudstack_secret_key', String, 'first', '')
  $cloudstack_url        = lookup('cloudstack_url', String, 'first', 'https://cloud.swisstxt.ch/client/api')

  if $::platform_services::manage_front_ips and $cloudstack_api_key != '' and $cloudstack_secret_key != '' {
    class{'::cloudstack::controller':
      url        => $cloudstack_url,
      api_key    => $cloudstack_api_key,
      secret_key => $cloudstack_secret_key,
      project    => inline_template("<%= scope.lookupvar('::mpc_bu').upcase %>_<%= scope.lookupvar('::mpc_project').upcase %>"),
    }
    Cloudstack_firewall_rule <<||>>
    Cloudstack_port_forwarding <<||>>
    Cloudstack_secondary_ip <<||>>
  }
}
