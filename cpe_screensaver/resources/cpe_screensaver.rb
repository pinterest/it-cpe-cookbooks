#
# Cookbook Name:: cpe_screensaver
# Resource:: cpe_screensaver
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_screensaver
default_action :run

# Enforce screen saver settings
action :run do
  ss_prefs = node['cpe_screensaver'].reject { |_k, v| v.nil? }
  if ss_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end
  unless node['cpe_screensaver']['idleTime'].nil?
    unless node['cpe_screensaver']['idleTime'] <= 600
      Chef::Log.warn(
        'Screensaver idle time is too high!')
    end
  end
  unless node['cpe_screensaver']['askForPasswordDelay'].nil?
    unless node['cpe_screensaver']['askForPasswordDelay'] <= 5
      Chef::Log.warn(
        'Screensaver password delay is too high!')
    end
  end

  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  ss_profile = {
    'PayloadIdentifier' => "#{prefix}.screensaver",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => '4FF566A6-269C-464A-9227-4D75D6313D45',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'ScreenSaver',
    'PayloadContent' => [],
  }
  unless ss_prefs.empty?
    ss_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.screensaver',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.screensaver",
      'PayloadUUID' => '72E5524A-3EC0-4877-96C0-07901F2E49E9',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'ScreenSaver',
    )
    ss_prefs.each_key do |key|
      next if ss_prefs[key].nil?
      ss_profile['PayloadContent'][0][key] = ss_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.screensaver"] = ss_profile
end
