#
# Cookbook:: cpe_helloit
# Resources:: cpe_helloit_la
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_helloit_la
provides :cpe_helloit_la, :os => 'darwin'
default_action :manage

action :manage do
  return unless node['cpe_helloit']['install']
  return unless node['cpe_helloit']['manage_la']

  # Manage Hello-IT's default scripts and custom folders
  # Create the main directory first
  directory '/Library/Application Support/com.github.ygini.hello-it' do
    owner 'root'
    group 'wheel'
    mode '0755'
    recursive true
    path '/Library/Application Support/com.github.ygini.hello-it'
    action :create
  end
  # Use remote_directory to add any custom contents
  [
    'CustomImageForItem',
    'CustomScripts',
    'CustomStatusBarIcon',
  ].each do |item|
    remote_directory item do
      source "helloit/#{item}"
      owner 'root'
      group 'wheel'
      mode '0755'
      files_mode '0755'
      path "/Library/Application Support/com.github.ygini.hello-it/#{item}"
      purge true
      action :create
    end
  end

  # Launch Agent
  node.default['cpe_launchd']['com.github.ygini.hello-it'] =
    node.default['cpe_helloit']['la']
end
