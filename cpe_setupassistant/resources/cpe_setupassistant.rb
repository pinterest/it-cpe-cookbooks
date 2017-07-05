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

sa_prefs = {}

action :run do
  sa_prefs = node['cpe_setupassistant'].reject { |_k, v| v.nil? }
  unless sa_prefs.empty?
    organization = node['organization'] ? node['organization'] : 'Pinterest'
    prefix = node['cpe_profiles']['prefix']
    node.default['cpe_profiles']["#{prefix}.setupassistant"] = {
      'PayloadIdentifier' => "#{prefix}.setupassistant",
      'PayloadRemovalDisallowed' => true,
      'PayloadScope' => 'System',
      'PayloadType' => 'Configuration',
      'PayloadUUID' => '552E2A87-2B97-4626-AAE1-DF2113960074',
      'PayloadOrganization' => organization,
      'PayloadVersion' => 1,
      'PayloadDisplayName' => 'SetupAssistant',
      'PayloadContent' => [
        {
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
                  'mcx_preference_settings' => sa_prefs,
                },
              ],
            },
          },
        },
      ],
    }
  end
end
