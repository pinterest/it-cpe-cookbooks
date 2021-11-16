# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2

name 'cpe_softwareupdate'
maintainer 'Pinterest'
maintainer_email 'itcpe@pinterest.com'
license 'Apache-2.0'
description 'Installs/Configures cpe_softwareupdate'
version '0.1.0'
chef_version '>= 14.14' if respond_to?(:chef_version)
supports 'mac_os_x'

depends 'cpe_profiles'
