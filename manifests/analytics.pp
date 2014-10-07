#
# Class: contrail::analytics
#   Manage contrail analytics
#
#
class contrail::analytics (
  $package_ensure = 'present',

) {

  package {'contrail-analytics':
    ensure => $package_ensure,
  }


}
