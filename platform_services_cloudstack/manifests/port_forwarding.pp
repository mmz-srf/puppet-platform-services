define platform_services_cloudstack::port_forwarding(
  $front_ip,
  $protocol    = 'tcp',
  $port        = $name,
  $cidrlist    = "0.0.0.0/0"
  $vm_guest_ip = "0.0.0.0",
) {
  debug("${caller_module_name}->${module_name} : Configuring Portforwarding with front_id:${front_ip}, protocol:${protocol}, port:${port}")

  if $::platform_services::manage_front_ips {
    @@cloudstack_port_forwarding {"$::fqdn/$vm_guest_ip/$protocol/$name":
      ensure             => present,
      front_ip           => $front_ip,
      protocol           => $protocol,
      privateport        => $port,
      publicport         => $port,
      virtual_machine_id => $::instance_id,
      cidrlist           => $cidrlist,
      vm_guest_ip        => $vm_guest_ip,
    }
  }
}
