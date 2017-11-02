#
# Cookbook Name:: cpe_crypt
# Resources:: cpe_crypt_ld
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_crypt_ld
provides :cpe_crypt_ld, :os => 'darwin'
default_action :manage

action :manage do
  return unless node['cpe_crypt']['install']
  return unless node['cpe_crypt']['manage_ld']

  # Manage Crypt checkin script and folder
  remote_directory '/Library/Crypt' do
    source 'crypt'
    owner 'root'
    group 'wheel'
    mode '0755'
    files_mode '0755'
    purge true
    action :create
  end

  # Launch Daemon
  node.default['cpe_launchd']['com.grahamgilbert.crypt'] =
    node.default['cpe_crypt']['ld']
end
