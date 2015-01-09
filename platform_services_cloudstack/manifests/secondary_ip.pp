define platform_services_cloudstack::secondary_ip (
  $ipaddress,
) {
  debug("${caller_module_name}->${module_name} : Configuring secondary ip address:${ipaddress}")

  if $::platform_services::manage_front_ips {
    @@cloudstack_secondary_ip {"$ipaddress":
      ensure             => present,
      virtual_machine_id => $::instance_id,
      ipaddress          => $ipaddress,
    }
  }
}
