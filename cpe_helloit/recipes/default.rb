#
# Cookbook:: cpe_helloit
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

return unless macos?

cpe_helloit_install 'Install Hello-IT package'
if node.os_at_least_or_lower?('10.15.99')
  cpe_helloit_profile 'Apply Hello-IT profile'
else
  cpe_helloit_defaults 'Apply Hello-IT defaults'
end
cpe_helloit_la 'Manage Hello-IT LaunchAgent'
