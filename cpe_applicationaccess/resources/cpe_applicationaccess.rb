#
# Cookbook:: cpe_applicationaccess
# Resource:: cpe_applicationaccess
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_applicationaccess
default_action :run

action :run do
  aa_prefs = node['cpe_applicationaccess']['features'].reject { |_k, v| v.nil? }
  aan_prefs = node['cpe_applicationaccess']['lists'].reject { |_k, v| v.nil? }
  if aa_prefs.empty? && aan_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  organization = node['organization'] ? node['organization'] : 'GitHub'
  prefix = node['cpe_profiles']['prefix']
  aa_profile = {
    'PayloadIdentifier' => "#{prefix}.applicationaccess",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => 'D1B78DD9-13A1-4BC5-9F22-EF10042F6041',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Application Restrictions',
    'PayloadContent' => [],
  }
  unless aa_prefs.empty?
    aa_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.applicationaccess',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.applicationaccess",
      'PayloadUUID' => '6493D033-179A-4E8D-AD85-FDBD09A28DCC',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'Application Restrictions',
    )

    aa_prefs.each_key do |key|
      next if aa_prefs[key].nil?
      aa_profile['PayloadContent'][0][key] = aa_prefs[key]
    end
  end

  unless aan_prefs.empty?
    aa_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.applicationaccess.new',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.applicationaccess.new",
      'PayloadUUID' => '23E11571-624B-4B74-89C0-12226EEEACD1',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'Application Restrictions New',
      'familyControlsEnabled' => true,
    )

    aan_prefs.each_key do |key|
      next if aan_prefs[key].nil?
      aa_profile['PayloadContent'][-1][key] = aan_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.applicationaccess"] = aa_profile
end
