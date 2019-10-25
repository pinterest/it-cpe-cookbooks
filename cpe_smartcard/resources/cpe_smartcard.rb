#
# Cookbook:: cpe_smartcard
# Resource:: cpe_smartcard
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_smartcard
default_action :run

# Enforce Smart Card settings
action :run do
  sc_prefs = node['cpe_smartcard'].reject { |_k, v| v.nil? }
  if sc_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  sc_profile = {
    'PayloadIdentifier' => "#{prefix}.smartcard",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => '83FAE4FC-9419-4256-AAC0-B566DAB8B667',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Smart Card',
    'PayloadContent' => [],
  }
  unless sc_prefs.empty?
    sc_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.security.smartcard',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.smartcard",
      'PayloadUUID' => 'F95EBD39-45CB-4658-B038-C656057D527C',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'Password Policy and ScreenSaver',
    )
    sc_prefs.each_key do |key|
      next if sc_prefs[key].nil?
      sc_profile['PayloadContent'][0][key] = sc_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.smartcard"] = sc_profile
end
