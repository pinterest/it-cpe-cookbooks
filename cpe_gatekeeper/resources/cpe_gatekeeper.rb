#
# Cookbook Name:: cpe_gatekeeper
# Resource:: cpe_gatekeeper
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_gatekeeper
default_action :run

action :run do
  gk_prefs = node['cpe_gatekeeper']['control'].reject { |_k, v| v.nil? }
  gkm_prefs = node['cpe_gatekeeper']['managed'].reject { |_k, v| v.nil? }
  if gk_prefs.empty? && gkm_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  organization = node['organization'] ? node['organization'] : 'Pinterest'
  prefix = node['cpe_profiles']['prefix']
  gk_profile = {
    'PayloadIdentifier' => "#{prefix}.systempolicy",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => '478DFE8E-E78A-4EDA-B04C-5C76BB0DACF9',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Gatekeeper',
    'PayloadContent' => [],
  }
  unless gk_prefs.empty?
    gk_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.systempolicy.control',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.systempolicy.control",
      'PayloadUUID' => 'BA7A3E1D-3646-4A1B-9561-1C49653972DC',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'System Policy Control',
    )

    gk_prefs.keys.each do |key|
      next if gk_prefs[key].nil?
      gk_profile['PayloadContent'][0][key] = gk_prefs[key]
    end
  end

  unless gkm_prefs.empty?
    gk_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.systempolicy.managed',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.systempolicy.managed",
      'PayloadUUID' => 'A31CD444-DEAF-43AB-A3D9-A6920719BAC4',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'System Policy Managed',
    )

    gkm_prefs.keys.each do |key|
      next if gkm_prefs[key].nil?
      gk_profile['PayloadContent'][-1][key] = gkm_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.systempolicy"] = gk_profile
end
