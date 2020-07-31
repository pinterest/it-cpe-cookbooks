#
# Cookbook:: cpe_helloit
# Resource:: cpe_helloit_profile
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_helloit_profile
provides :cpe_helloit_profile, :os => 'darwin'

default_action :config

# Enforce HelloIT settings
action :config do
  return unless node['cpe_helloit']['install']
  return unless node['cpe_helloit']['profile']

  hit_prefs = node['cpe_helloit']['prefs'].reject { |_k, v| v.nil? }
  if hit_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  hit_profile = {
    'PayloadIdentifier' => "#{prefix}.helloit",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => 'F51AC3AB-5899-4871-B543-39A9DC19A494',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Hello IT Application Preferences',
    'PayloadContent' => [],
  }
  unless hit_prefs.empty?
    hit_profile['PayloadContent'].push(
      'PayloadType' => 'com.github.ygini.Hello-IT',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.helloit",
      'PayloadUUID' => 'E19A9326-64D3-4C82-9B1D-3A6264382D5E',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'Hello IT Application Preferences',
    )
    hit_prefs.each_key do |key|
      next if hit_prefs[key].nil?
      hit_profile['PayloadContent'][0][key] = hit_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.helloit"] = hit_profile
end
