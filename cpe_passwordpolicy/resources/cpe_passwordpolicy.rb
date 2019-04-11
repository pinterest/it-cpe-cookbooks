#
# Cookbook Name:: cpe_passwordpolicy
# Resource:: cpe_passwordpolicy
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_passwordpolicy
default_action :run

# Enforce password policy and screensaver settings
action :run do
  pp_prefs = node['cpe_passwordpolicy'].reject { |_k, v| v.nil? }
  if pp_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end
  unless node['cpe_passwordpolicy']['maxInactivity'].nil?
    unless node['cpe_passwordpolicy']['maxInactivity'] >= 10
      Chef::Log.warn('maxInactivity time is too high!')
    end
  end
  unless node['cpe_passwordpolicy']['maxGracePeriod'].nil?
    unless node['cpe_passwordpolicy']['maxGracePeriod'] >= 0.08
      Chef::Log.warn('maxGracePeriod password delay is too high!')
    end
  end

  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  pp_profile = {
    'PayloadIdentifier' => "#{prefix}.passwordpolicy",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => 'CEA1E58D-9D0F-453A-AA52-830986A8366C',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Password Policy and ScreenSaver',
    'PayloadContent' => [],
  }
  unless pp_prefs.empty?
    pp_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.mobiledevice.passwordpolicy',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.passwordpolicy",
      'PayloadUUID' => '3B2AD6A9-F99E-4813-980A-4147617B2E75',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'Password Policy and ScreenSaver',
    )
    pp_prefs.each_key do |key|
      next if pp_prefs[key].nil?
      pp_profile['PayloadContent'][0][key] = pp_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.passwordpolicy"] = pp_profile
end
