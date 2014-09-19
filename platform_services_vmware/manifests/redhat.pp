class platform_services_vmware::redhat {
  if $::virtual == 'vmware' {
    package { 'open-vm-tools':
      ensure => latest,
    } ~>
    service { 'vmtoolsd':
      ensure => running,
      enable => true,
      hasstatus => true,
      hasrestart => true,
    }
  }
}
