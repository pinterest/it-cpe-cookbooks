# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2

name 'cpe_applicationaccess'
maintainer 'Pinterest'
maintainer_email 'itcpe@pinterest.com'
license 'Apache-2.0'
description 'Manages Apple System Preference Panes settings / profile'
version '0.1.0'
chef_version '>= 14.14'
supports 'mac_os_x'

depends 'cpe_profiles'
