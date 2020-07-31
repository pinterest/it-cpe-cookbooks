#
# Cookbook:: cpe_setupassistant
# Resources:: cpe_setupassistant
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_setupassistant
provides :cpe_setupassistant, :os => 'darwin'

default_action :run

action :run do
  saonce_prefs = node['cpe_setupassistant']['once'].reject { |_k, v| v.nil? }
  sam_prefs = node['cpe_setupassistant']['managed'].reject { |_k, v| v.nil? }
  if saonce_prefs.empty? && sam_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  organization = node['organization'] ? node['organization'] : 'Pinterest'
  prefix = node['cpe_profiles']['prefix']
  unless saonce_prefs.empty?
    sa_profile = {
      'PayloadIdentifier' => "#{prefix}.setupassistant",
      'PayloadRemovalDisallowed' => true,
      'PayloadScope' => 'System',
      'PayloadType' => 'Configuration',
      'PayloadUUID' => '552E2A87-2B97-4626-AAE1-DF2113960074',
      'PayloadOrganization' => organization,
      'PayloadVersion' => 1,
      'PayloadDisplayName' => 'SetupAssistant',
      'PayloadContent' => [],
    }
    sa_profile['PayloadContent'].push(
      {
        'PayloadType' => 'com.apple.ManagedClient.preferences',
        'PayloadVersion' => 1,
        'PayloadIdentifier' => "#{prefix}.setupassistant.once",
        'PayloadUUID' => '4CB98425-1FA5-46FE-B68C-DCDA1C7A6960',
        'PayloadEnabled' => true,
        'PayloadDisplayName' => 'SetupAssistant (Once)',
        'PayloadContent' => {
          'com.apple.SetupAssistant' => {
            'Set-Once' => [
              {
                'mcx_preference_settings' => saonce_prefs,
              },
            ],
          },
        },
      },
    )
    node.default['cpe_profiles']["#{prefix}.setupassistant"] = sa_profile
  end

  unless sam_prefs.empty?
    sam_profile = {
      'PayloadIdentifier' => "#{prefix}.setupassistant.managed",
      'PayloadRemovalDisallowed' => true,
      'PayloadScope' => 'System',
      'PayloadType' => 'Configuration',
      'PayloadUUID' => '4616f49c-5a67-4fb5-a3e5-c6855be7f8ba',
      'PayloadOrganization' => organization,
      'PayloadVersion' => 1,
      'PayloadDisplayName' => 'SetupAssistant',
      'PayloadContent' => [],
    }
    sam_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.SetupAssistant.managed',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.setupassistant.managed",
      'PayloadUUID' => 'e7350af3-e683-4329-8eb0-11bd960d9fff',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'SetupAssistant (Managed)',
    )
    sam_prefs.each_key do |key|
      next if sam_prefs[key].nil?
      sam_profile['PayloadContent'][0][key] = sam_prefs[key]
    end

    node.default['cpe_profiles']["#{prefix}.setupassistant.managed"] =
      sam_profile
  end
end
