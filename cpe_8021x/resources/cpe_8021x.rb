#
# Cookbook Name:: cpe_8021x
# Resource:: cpe_8021x
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2018-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_8021x
default_action :run

# Enforce 802.1x Settings
action :run do
  ethernet_prefs = node['cpe_8021x']['ethernet'].reject { |_k, v| v.nil? }
  wifi_prefs = node['cpe_8021x']['wifi'].reject { |_k, v| v.nil? }
  debug_prefs = node['cpe_8021x']['debug'].reject { |_k, v| v.nil? }
  if ethernet_prefs.empty? && wifi_prefs.empty? && debug_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'

  eap_profile = {
    'PayloadIdentifier' => "#{prefix}.8021x",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => 'E2A50C04-135A-4C7B-A771-E4ABB88DE993',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => '802.1x',
    'PayloadContent' => [],
  }

  unless ethernet_prefs.empty?
    eap_profile['PayloadContent'].push(
      'PayloadType' => node['cpe_8021x']['ethernet']['PayloadType'] ?
        node['cpe_8021x']['ethernet']['PayloadType'] :
        'com.apple.firstethernet.managed',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.8021x.ethernet",
      'PayloadUUID' => 'FC43EE42-65AB-43AF-BD1C-A36DF8B847C4',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => '802.1x (Ethernet)',
    )

    ethernet_prefs.keys.each do |key|
      next if ethernet_prefs[key].nil?
      eap_profile['PayloadContent'][0][key] = ethernet_prefs[key]
    end
  end

  unless wifi_prefs.empty?
    eap_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.wifi.managed',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.8021x.wifi",
      'PayloadUUID' => '6873AEEB-BCBC-4FAC-865D-49025CBBD789',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => '802.1x (Wifi)',
    )

    wifi_prefs.keys.each do |key|
      next if wifi_prefs[key].nil?
      eap_profile['PayloadContent'][-1][key] = wifi_prefs[key]
    end
  end

  unless debug_prefs.empty?
    if node['cpe_8021x']['debug']['PrintPlist'] == true
      print eap_profile.to_plist
    end
  end

  node.default['cpe_profiles']["#{prefix}.8021x"] = eap_profile
end
