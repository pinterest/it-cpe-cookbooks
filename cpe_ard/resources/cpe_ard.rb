#
# Cookbook Name:: cpe_ard
# Resource:: cpe_ard
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_ard
default_action :run

ard_prefs = {}

action :run do
  ard_prefs = node['cpe_ard'].reject { |_k, v| v.nil? }
  return if ard_prefs.empty?
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  prefix = node['cpe_profiles']['prefix']
  node.default['cpe_profiles']["#{prefix}.ard"] = {
    'PayloadIdentifier' => "#{prefix}.ardapp",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => '2CAB3C80-54C4-4D61-A142-52C2EBB0DA8C',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Apple Remote Desktop Application',
    'PayloadContent' => [
      {
        'PayloadType' => 'com.apple.ManagedClient.preferences',
        'PayloadVersion' => 1,
        'PayloadIdentifier' => "#{prefix}.ard",
        'PayloadUUID' => '149EAD29-D27D-4639-8E8D-D8513B18A2B5',
        'PayloadEnabled' => true,
        'PayloadDisplayName' => 'RemoteManagement',
        'PayloadContent' => {
          'com.apple.RemoteManagement' => {
            'Forced' => [
              {
                'mcx_preference_settings' => ard_prefs,
              },
            ],
          },
        },
      },
    ],
  }
end
