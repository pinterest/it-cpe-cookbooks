#
# Cookbook:: cpe_firewall
# Resource:: cpe_firewall
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_firewall
provides :cpe_firewall, :os => 'darwin'

default_action :run

# Enforce firewall settings
action :run do
  fw_prefs = node['cpe_firewall'].reject { |_k, v| v.nil? }
  if fw_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end
  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  fw_profile = {
    'PayloadIdentifier' => "#{prefix}.firewallpolicy",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => '14B18D66-448C-46E0-B54F-D70DFF7BA302',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Firewall Policy',
    'PayloadContent' => [],
  }
  unless fw_prefs.empty?
    fw_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.security.firewall',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.firewallpolicy",
      'PayloadUUID' => '9D929A84-994C-497C-8F34-DB32FACB25CD',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'Firewall Policy',
    )
    fw_prefs.each_key do |key|
      next if fw_prefs[key].nil?
      fw_profile['PayloadContent'][0][key] = fw_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.firewallpolicy"] = fw_profile
end
