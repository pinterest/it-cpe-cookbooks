#
# Cookbook:: cpe_crypt
# Resources:: cpe_crypt_ld
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
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

  # Manage Crypt checkin folder
  directory '/Library/Crypt' do
    owner 'root'
    group 'wheel'
    mode '0755'
  end

  # Define and install crypt checkin files
  %w[
    checkin
    FoundationPlist.py
  ].each do |item|
    cookbook_file "/Library/Crypt/#{item}" do
      owner 'root'
      group 'wheel'
      mode '0755'
      path "/Library/Crypt/#{item}"
      source "crypt/#{item}"
    end
  end

  # Launch Daemon
  node.default['cpe_launchd']['com.grahamgilbert.crypt'] =
    node.default['cpe_crypt']['ld']
end
