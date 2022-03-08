#
# Cookbook:: cpe_preferencesecurity
# Resource:: cpe_preferencesecurity
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_preferencesecurity
default_action :run
unified_mode true

# Enforce preference security settings
action :run do
  ps_prefs = node['cpe_preferencesecurity'].compact
  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  ps_profile = {
    'PayloadIdentifier' => "#{prefix}.preferencesecurity",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => '316A8FD3-EDA5-464B-9533-636B8818097C',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Preference Security',
    'PayloadContent' => [],
  }
  unless ps_prefs.empty?
    ps_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.preference.security',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.preferencesecurity",
      'PayloadUUID' => 'ACE7F9CF-3A7A-40E3-A386-C6F18B92C4AB',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'Preference Security',
    )
    ps_prefs.each_key do |key|
      next if ps_prefs[key].nil?
      ps_profile['PayloadContent'][0][key] = ps_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.preferencesecurity"] = ps_profile
end
