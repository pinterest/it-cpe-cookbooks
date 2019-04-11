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

# Enforce Apple Remote Desktop (Application) settings
action :run do
  ard_prefs = node['cpe_ard'].reject { |_k, v| v.nil? }
  if ard_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  ard_profile = {
    'PayloadIdentifier' => "#{prefix}.ardapp",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => '2CAB3C80-54C4-4D61-A142-52C2EBB0DA8C',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Apple Remote Desktop Application',
    'PayloadContent' => [],
  }
  unless ard_prefs.empty?
    ard_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.RemoteManagement',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.ardapp",
      'PayloadUUID' => '149EAD29-D27D-4639-8E8D-D8513B18A2B5',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'Apple Remote Desktop Application',
    )
    ard_prefs.each_key do |key|
      next if ard_prefs[key].nil?
      ard_profile['PayloadContent'][0][key] = ard_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.ard"] = ard_profile
end
