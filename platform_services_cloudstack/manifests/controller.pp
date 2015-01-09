class platform_services_cloudstack::controller {
  $cloudstack_api_key    = hiera('cloudstack_api_key', false)
  $cloudstack_secret_key = hiera('cloudstack_secret_key', false)
  $cloudstack_url        = hiera('cloudstack_url', 'https://cloud.swisstxt.ch/client/api')

  if $::platform_services::manage_front_ips and $cloudstack_api_key and $cloudstack_secret_key {
    class{'::cloudstack::controller':
      url        => $cloudstack_url,
      api_key    => $cloudstack_api_key,
      secret_key => $cloudstack_secret_key,
      project    => inline_template("<%= scope.lookupvar('::mpc_bu').upcase %>_<%= scope.lookupvar('::mpc_project').upcase %>"),
    }
    Cloudstack_port_forwarding <<||>>
    Cloudstack_secondary_ip <<||>>
  }
}
