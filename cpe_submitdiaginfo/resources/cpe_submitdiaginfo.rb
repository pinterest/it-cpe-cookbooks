#
# Cookbook Name:: cpe_submitdiaginfo
# Resource:: cpe_submitdiaginfo
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_submitdiaginfo
default_action :run

# Enforce Submit Diag Info settings
action :run do
  sd_prefs = node['cpe_submitdiaginfo'].reject { |_k, v| v.nil? }
  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  sd_profile = {
    'PayloadIdentifier' => "#{prefix}.submitdiaginfo",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => 'C508D5C7-F9CE-4AC5-AE60-4583706B7866',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Submit Diag Info',
    'PayloadContent' => [],
  }
  unless sd_prefs.empty?
    sd_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.SubmitDiagInfo',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.submitdiaginfo",
      'PayloadUUID' => '9241E172-6B8B-4C2D-91B4-F48854F9A3F4',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'Submit Diag Info',
    )
    sd_prefs.each_key do |key|
      next if sd_prefs[key].nil?
      sd_profile['PayloadContent'][0][key] = sd_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.submitdiaginfo"] = sd_profile
end
