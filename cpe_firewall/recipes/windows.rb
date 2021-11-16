#
# Cookbook:: cpe_firewall
# Recipe:: windows
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

return unless windows?

windows_service 'firewall' do
  service_name 'MpsSvc'
  run_as_user 'NT AUTHORITY\LocalService'
  startup_type :automatic
  action :start
end
