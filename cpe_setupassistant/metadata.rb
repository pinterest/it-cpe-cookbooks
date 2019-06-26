# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2

name 'cpe_setupassistant'
maintainer 'Pinterest'
maintainer_email 'itcpe@pinterest.com'
license 'Apache'
description 'Manages SetupAssistant settings / profile'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'
supports 'mac_os_x'

depends 'cpe_profiles'
