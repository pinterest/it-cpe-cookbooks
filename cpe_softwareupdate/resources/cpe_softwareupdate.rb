#
# Cookbook Name:: cpe_softwareupdate
# Resource:: cpe_softwareupdate
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_softwareupdate
default_action :run

# Enforce SoftwareUpdate settings
action :run do
  susu_prefs = node['cpe_softwareupdate']['su'].reject { |_k, v| v.nil? }
  suc_prefs = node['cpe_softwareupdate']['commerce'].reject { |_k, v| v.nil? }
  if susu_prefs.empty? && suc_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  organization = node['organization'] ? node['organization'] : 'Pinterest'
  prefix = node['cpe_profiles']['prefix']
  su_profile = {
    'PayloadIdentifier' => "#{prefix}.softwareupdate",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => '4BD8EB2F-6D7F-484B-8638-54FCD842AD35',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'SoftwareUpdate',
    'PayloadContent' => [],
  }
  unless susu_prefs.empty?
    su_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.SoftwareUpdate',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.softwareupdate",
      'PayloadUUID' => '93190E8F-8820-4378-82AF-9F7BF071A06E',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'SoftwareUpdate (SoftwareUpdate)',
    )

    susu_prefs.keys.each do |key|
      next if susu_prefs[key].nil?
      su_profile['PayloadContent'][0][key] = susu_prefs[key]
    end
  end

  unless suc_prefs.empty?
    su_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.commerce',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.commerce",
      'PayloadUUID' => 'EA6ABD99-B904-4A36-A312-349AF97E1D4D',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'SoftwareUpdate (Commerce)',
      'familyControlsEnabled' => true,
    )

    suc_prefs.keys.each do |key|
      next if suc_prefs[key].nil?
      su_profile['PayloadContent'][-1][key] = suc_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.softwareupdate"] = su_profile
end
