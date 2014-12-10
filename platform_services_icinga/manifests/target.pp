class platform_services_icinga::target (
  $ping_check           = present,
  $cpu_check            = present,
  $memory_check         = present,
  $load_check           = present,
  $processes_check      = present,
  $root_partition_check = present,
  $swap_check           = present,
  $hostgroups           = undef,
){
  include ::platform_services_firewall::nrpe

  Icinga::Service {
    use => 'generic-service',
    use_nrpe => true,
  }

  class{'::icinga::target':
    use        => 'linux-server',
    hostgroups => $hostgroups,
  }
  class{'::icinga::nrpe':
    nrpe_allowed_hosts => "127.0.0.1,10.0.0.0/8",
  }
  icinga::service{
    'ping':
      service_description => 'Ping',
      check_command => 'check_ping!200.0,5%!400.0,10%',
      ensure   => $ping_check,
      use_nrpe => false;
    'cpu':
      service_description => 'CPU Usage',
      ensure   => $cpu_check,
      check_command => 'check_cpu';
    'memory':
      service_description => 'Memory Usage',
      ensure   => $memory_check,
      check_command => 'check_memory';
    'load':
      service_description => 'Load',
      check_command => 'check_load',
      ensure   => $load_check,
      nrpe_args => '10.0,8.0,6.0\!20.0,15.0,10.0';
    'total-processes':
      service_description => 'Total Processes',
      check_command => 'check_procs',
      ensure   => $processes_check,
      nrpe_args => '150\!300\!RSZDT';
    'root-partition':
      service_description => 'Root Partition',
      check_command => 'check_disk_all',
      ensure   => $root_partition_check,
      nrpe_args => '10%\!5%';
    'swap':
      service_description => 'Swap',
      check_command => 'check_swap',
      ensure   => $swap_check,
      nrpe_args => '50%\!10%';
  }
  case $osfamily {
     'RedHat': {
        include ::platform_services_icinga::target::redhat
     }   
     'Debian': {
        # 
     }   
  }
}
