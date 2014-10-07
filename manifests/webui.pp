#
# Class: contrail::webui
#   Provide web based user interface for contrail management and analytics
#
class contrail::webui (
  $package_ensure = 'installed',
) {
  package { 'contrail-openstack-webui' :
    ensure => $package_ensure,
  }
}
