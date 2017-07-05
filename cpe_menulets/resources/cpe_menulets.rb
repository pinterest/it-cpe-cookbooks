#
# Cookbook Name:: cpe_menulets
# Resources:: cpe_menulets
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_menulets
default_action :run

ml_prefs = {}

action :run do
  ml_prefs = node['cpe_menulets'].reject { nil? }
  return if ml_prefs.empty?
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  prefix = node['cpe_profiles']['prefix']
  node.default['cpe_profiles']["#{prefix}.menulet"] = {
    'PayloadIdentifier' => "#{prefix}.menulet",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => '2E33AB8C-AFF6-4BA7-8110-412EC841423E',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Menulet',
    'PayloadContent' => [
      {
        'PayloadType' => 'com.apple.ManagedClient.preferences',
        'PayloadVersion' => 1,
        'PayloadIdentifier' => "#{prefix}.menulet",
        'PayloadUUID' => '37F77492-E026-423F-8F7B-567CC06A7585',
        'PayloadEnabled' => true,
        'PayloadDisplayName' => 'Menulet',
        'PayloadContent' => {
          'com.apple.systemuiserver' => {
            'Forced' => [
              {
                'mcx_preference_settings' => {
                  'menuExtras' => ml_prefs,
                },
              },
            ],
          },
        },
      },
    ],
  }
end
