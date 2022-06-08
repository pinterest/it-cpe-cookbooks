#
# Cookbook:: cpe_helloit
# Resource:: cpe_helloit_defaults
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2022-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#
unified_mode true

resource_name :cpe_helloit_defaults
provides :cpe_helloit_defaults, :os => 'darwin'

default_action :config

# Enforce HelloIT settings
action :config do
  return unless node['cpe_helloit']['install']
  return unless node['cpe_helloit']['config']

  hit_prefs = node['cpe_helloit']['prefs'].compact
  if hit_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  if node.at_least_chef14? # Chef 14+ for macos_userdefaults
    hit_prefs.each_key do |key|
      next if hit_prefs[key].nil?

      macos_userdefaults "Configure com.github.ygini.Hello-IT - #{key}" do
        domain '/Library/Preferences/com.github.ygini.Hello-IT'
        key key
        value hit_prefs[key].to_array
        host :all
        user :all
      end
    end
  end
end
