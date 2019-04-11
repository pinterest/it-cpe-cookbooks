#
# Cookbook Name:: cpe_crypt
# Resources:: cpe_crypt_profile
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_crypt_profile
default_action :config

action :config do
  return unless node['cpe_crypt']['install']
  return unless node['cpe_crypt']['profile']

  crypt_prefs = node['cpe_crypt']['prefs'].reject { |_k, v| v.nil? }
  if crypt_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  crypt_profile = {
    'PayloadIdentifier' => "#{prefix}.crypt",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => '28A33C8B-6808-4457-B6CC-F866AD3272C2',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Crypt',
    'PayloadContent' => [],
  }
  unless crypt_prefs.empty?
    crypt_profile['PayloadContent'].push(
      'PayloadType' => 'com.grahamgilbert.crypt',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.crypt",
      'PayloadUUID' => 'F9A5E8E1-3C08-4D32-94A5-325009F9C999',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'Crypt',
    )
    crypt_prefs.each_key do |key|
      next if crypt_prefs[key].nil?
      crypt_profile['PayloadContent'][0][key] = crypt_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.crypt"] = crypt_profile
end
