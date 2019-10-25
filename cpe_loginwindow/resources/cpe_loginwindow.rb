#
# Cookbook:: cpe_loginwindow
# Resources:: cpe_loginwindow
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_loginwindow
default_action :run

action :run do
  lw_prefs = node['cpe_loginwindow'].reject { |_k, v| v.nil? }
  if lw_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  lw_profile = {
    'PayloadIdentifier' => "#{prefix}.loginwindow",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => 'C23131A0-FB9B-4340-B6A1-DFF047452174',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'LoginWindow',
    'PayloadContent' => [],
  }
  unless lw_prefs.empty?
    lw_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.loginwindow',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.loginwindow",
      'PayloadUUID' => '250697B2-654D-4E71-A7A6-EAB9255F9294',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'LoginWindow',
    )
    lw_prefs.each_key do |key|
      next if lw_prefs[key].nil?
      lw_profile['PayloadContent'][0][key] = lw_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.loginwindow"] = lw_profile
end
