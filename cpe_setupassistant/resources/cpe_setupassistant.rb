#
# Cookbook Name:: cpe_setupassistant
# Resources:: cpe_setupassistant
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_setupassistant
default_action :run

action :run do
  ss_once = node['cpe_setupassistant']['once'].reject { |_k, v| v.nil? }
  ss_managed = node['cpe_setupassistant']['managed'].reject { |_k, v| v.nil? }
  if ss_once.empty? && ss_managed.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end
  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  ss_profile = {
    'PayloadIdentifier' => "#{prefix}.setupassistant",
    'PayloadRemovalDisslowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => 'C552E2A87-2B97-4626-AAE1-DF2113960074',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'SetupAssistant',
    'PayloadContent' => [],
  }
  # Set-Once settings
  unless ss_once.empty?
    ss_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.ManagedClient.preferences',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.setupassistant",
      'PayloadUUID' => '4CB98425-1FA5-46FE-B68C-DCDA1C7A6960',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'SetupAssistant',
      'PayloadContent' => {
        'PayloadType' => 'com.apple.ManagedClient.preferences',
        'PayloadVersion' => 1,
        'PayloadIdentifier' => "#{prefix}.setupassistant",
        'PayloadUUID' => '4CB98425-1FA5-46FE-B68C-DCDA1C7A6960',
        'PayloadEnabled' => true,
        'PayloadDisplayName' => 'SetupAssistant',
        'PayloadContent' => {
          'com.apple.SetupAssistant' => {
            'Set-Once' => [
              {
                'mcx_preference_settings' => ss_once,
              },
            ],
          },
        },
      },
    )
  end
  # Managed Settings
  unless ss_managed.empty?
    index = ss_profile['PayloadContent'].length
    ss_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.SetupAssistant.managed',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.setupassistant.managed",
      'PayloadUUID' => '4616f49c-5a67-4fb5-a3e5-c6855be7f8ba',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'SetupAssistant',
    )
    ss_managed.keys.each do |key|
      next if ss_managed[key].nil?
      ss_profile['PayloadContent'][index][key] = ss_managed[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.setupassistant"] = ss_profile
end
