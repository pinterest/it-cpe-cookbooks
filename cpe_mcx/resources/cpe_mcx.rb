#
# Cookbook Name:: cpe_mcx
# Resource:: cpe_mcx
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_mcx
default_action :run

mcx_prefs = {}

action :run do
  mcx_prefs = node['cpe_mcx'].reject { |_k, v| v.nil? }
  return if mcx_prefs.empty?
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  prefix = node['cpe_profiles']['prefix']
  node.default['cpe_profiles']["#{prefix}.mcx"] = {
    'HasRemovalPasscode' => true,
    'PayloadIdentifier' => "#{prefix}.mcx",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => 'FF1D4C80-5951-401B-9324-AABCFDAC8EE0',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'MC X',
    'PayloadContent' => [
      {
        'PayloadType' => 'com.apple.ManagedClient.preferences',
        'PayloadVersion' => 1,
        'PayloadIdentifier' => "#{prefix}.mcx",
        'PayloadUUID' => '78175364-EB51-4366-BD39-6FB6C2EFA779',
        'PayloadEnabled' => true,
        'PayloadDisplayName' => 'MCX',
        'PayloadContent' => {
          'com.apple.MCX' => {
            'Forced' => [
              {
                'mcx_preference_settings' => mcx_prefs,
              },
            ],
          },
        },
      },
    ],
  }
end
