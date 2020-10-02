#
# Cookbook:: cpe_firewall
# Recipe:: default
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

return unless node.windows? || node['platform'] == 'macos' || node['platform'] == 'mac_os_x'

if node.windows?
  include_recipe 'cpe_firewall::windows'
elsif node['platform'] == 'macos' || node['platform'] == 'mac_os_x'
  include_recipe 'cpe_firewall::mac_os_x'
else
  Chef::Log.warn('cpe_firewall called on incompatible platform.')
end
