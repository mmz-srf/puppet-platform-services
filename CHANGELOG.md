## 1.1.10 (July 18, 2014)

Bugfixes:

  * Fix default cert and ldap settings in authconfig

## 1.1.9 (May 23, 2014)

Bugfixes:

  * Fix zone replication, remove hardcoded serial (Daniel Beyer, YMC AG)


## 1.1.8 (April 14, 2014)

Bugfixes:

  * vmtoolsd: ensure service running and enabled


## 1.1.7 (January 30, 2014)

  * update CHANGELOG


## 1.1.6 (January 23, 2014)

Bugfixes:

  * platform_services_icinga::target::redhat: fixed missing dependency, fixes SPS-84


## 1.1.5 (January 23, 2014)

Bugfixes:

  * platform_services_yum: fixed dependency cycle


## 1.1.4 (January 23, 2014)

  * Do not export cloudstack port-forwardings if $::platform_services::manage_front_ips is false
  * Repos moved to github


## 1.1.0 (November 26, 2013)

Features:

  * added possibility to use external classes for graylog server
  * add debian support for icinga
  * add debian suport for icinga-web
  * added new better network module
  * add debian support for graylog2
  * avoid duplicate resource declaration if $default_nameserver is equals to the current node-ip
  * add baseip function
  * made platform_services_resolvconf vagrant compatible
  * added domain for front-net in search-path
  * icinga: Added Puppetrun Check
  * Upate stdlib to version 4.0
  * haproxy: use last octet for virtual_router_id if not set
  * resolvconf: added timeout option, default is 3
  * icinga: removed duplicate version lock code block
  * icinga target: default checks can be turned off
  * use new network module
  * platform_services_vmware: new for installing vmware tools
  * Added new FACT 'mpc_role'
  * Added new puppet-function 'ipv4tohex'
  
Bugfixes:

  * disable puppetlabs yum repository
  * fixed mpc_network_front name for rsi
  * fixed cloudstack integration and port forwarding
  * fixed suport for nrpe plugins on target (clientside)
  * added changes in icinga module, removed unused files, fixed db installation
  * fixed mpc_ facts
  * updated service dns names to mach 
    https://wiki.swisstxt.ch/pages/viewpage.action?spaceKey=PO&title=DNS+MPC201
  * changed dns zone to match 
    https://wiki.swisstxt.ch/pages/viewpage.action?spaceKey=PO&title=DNS+MPC2012
  * fix in haproxy: Interfaces for Services with more than 10 chars did not came up
  * workaround for restarting network-interfaces in haproxy
  * full service name for haproxy:listen, shortened for network_config
  * resolvconf: set different domain name for front network
  * update concat module
  * fixed front network resolv config entry
  * hosts that reside in the front network must have their dns entries added to the front dns zone
  * plattformservices_resolvconf: Fixed an issue with duplicate exported ressources
  * haproxy: fixed hardcoded network netmask
  * Fixed subnetmask in Zonefiles
  * Fixed haproxy exported resources
  * fix for local VAgrant Boxes. They match without a Number
  * Fixed Regex for haproxy recognition
  * platform_services_network: added PEERDNS option to network config again, was removed in network module switch
  * make firewall rules persistent
  * Fixed an issue with aliases not unique enough in platform_services_haprox

Submodule changes:

  * boolean
  * cloudstack
  * concat
  * filemapper
  * graylog2
  * haproxy
  * icinga
  * keepalived
  * logrotate
  * mongodb
  * network
  * php
  * puppet
  * resolvconf
  * ruby
  * stdlib


## 1.0.2 (November 6, 2013)

Bugfixes:

  * selinux: set absent /selinux/enforce
  * icinga: ignore making a link to /var/icinga if directory exists


## 1.0.1 (October 17, 2013)

Bugfixes:

  * graylog2: fixed ldap can not be configured propperly
  * network: do not touch network config if system is physical


## 1.0.0 (September 27, 2013)

Features:

  * new dns concept: 
    * 2nd nameservers are ns3.swisstxt.ch and ns4.swisstxt.ch
    * default resolv conf will be (also as delivered by dhcp) cs-router, ns3.swisstxt.ch and ns4.swisstxt.ch
    * soa record changed to e.g. dns-bie-01.bie.prod.rts.mpc i.e. without 'serv'
  * selinux: enabled in base::redhat with default mode permissive
  * removed platform_services_resolvconf from base. resolv.conf is now managed by dhcp only 
    which fixes a race condition between pupppet and dhcp

Submodule changes:

  * selinux
  * platform_services_haproxy::member fixed typo in port forwardings


## 0.9.0 (September 17, 2013)

Bugfixes:

  * Tempaltes: fix variable lookups without @-prefix
  * Network: fixes for custom network support
  * fix mpc_network_front fact for new srf networks

Features:

  * platform_dns: use hostname for soa and ns entries
  * move alle submodules to either bitbucket or github
  * use https protocol for all submodules
  * platform_services_dns: add suport for networks other than /24
  * platform_services_dns::server: make interfaces parameterizable
  * make platform_services::dns debian compatible
  * disable management of front_ips via class param ::platform_services::manage_front_ips
  * refactor wording of vip into front_ip across the codebase
  * remove legacy facts project and region
  * make $vip-mappings a class parameter
  * ensure createrepo package is present
  * include yum in pre stage
  * include yum repo server only for redhat based systems
  * remote puppetmaster from must-provide top-scope variables
  * configure pre stage in platform_services
  * don't use disabled::service helper
  * make platform_services::base debian compatible
  * remove uneeded/unused submodule

Submdoules changes:

  * ssh
  * ntp
  * rsyslog
  * keepalived
  * icinga
  * graylog2
  * cloudstack
  * dns
  * mongodb
  * ruby
  * php
  * pakiti

Upgrade notes:

  if you encounter any occurance of 'vip' in your own codebase, 
  simply replace it with 'front_ip'.

  Users of the platform-services-skeleton must remove the "stage{'pre':"
  and "class{'yum':" declarations from manifests/settings.pp.


## 0.1.0 (July 17, 2013)

  * Changes to the Icinga module which allow an automatic installation, 
    configuration and update of the Icinga monitoring servers.

