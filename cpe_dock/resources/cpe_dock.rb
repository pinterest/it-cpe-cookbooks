#
# Cookbook:: cpe_dock
# Resources:: cpe_dock
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2018-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_dock
default_action :run

action :run do
  dock_prefs = node['cpe_dock'].reject { |_k, v| v.nil? }
  if dock_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  dock_profile = {
    'PayloadIdentifier' => "#{prefix}.dock",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => 'A30A75F3-E518-4E33-9A6B-61083F428A08',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Dock',
    'PayloadContent' => [],
  }
  unless dock_prefs.empty?
    dock_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.dock',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.dock",
      'PayloadUUID' => 'FB377593-8776-4A70-B55C-69D2E226DD6D',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'Dock',
    )
    dock_prefs.each_key do |key|
      next if dock_prefs[key].nil?
      dock_profile['PayloadContent'][0][key] = dock_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.dock"] = dock_profile
end
