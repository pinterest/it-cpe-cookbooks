#
# Cookbook Name:: cpe_crypt
# Resources:: cpe_crypt_files
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_crypt_files
default_action :run

action :run do
  return unless node['cpe_crypt']['install']

  # Manage Crypt checkin script and folder
  remote_directory '/Library/Crypt' do
    source 'crypt'
    owner 'root'
    group 'wheel'
    mode '0755'
    files_mode '0755'
    action :create
  end

  # Launch Daemon
  node.default['cpe_launchd']['crypt'] = {
    'program_arguments' => ['/Library/Crypt/checkin'],
    'disabled' => false,
    'run_at_load' => true,
    'start_interval' => 120,
    'type' => 'daemon',
  }

  # Delete default Crypt LaunchDaemon
  launchd 'com.grahamgilbert.crypt' do
    action :delete
  end
end
