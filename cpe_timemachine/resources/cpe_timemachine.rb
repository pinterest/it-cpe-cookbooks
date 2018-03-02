#
# Cookbook Name:: cpe_timemachine
# Resource:: cpe_timemachine
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2018-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_timemachine
default_action :run

# Enforce Time Machine settings
action :run do
  tm_prefs = node['cpe_timemachine'].reject { |_k, v| v.nil? }
  if tm_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  tm_profile = {
    'PayloadIdentifier' => "#{prefix}.timemachine",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => 'DA90E27E-5D08-4DDE-B8A0-AC77A36A6130',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Time Machine',
    'PayloadContent' => [],
  }
  unless tm_prefs.empty?
    tm_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.MCX.TimeMachine',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.timemachine",
      'PayloadUUID' => '6BBA1688-149A-4623-AD11-2C9BFBD8F2B6',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'Time Machine',
    )
    tm_prefs.keys.each do |key|
      next if tm_prefs[key].nil?
      tm_profile['PayloadContent'][0][key] = tm_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.timemachine"] = tm_profile
end
