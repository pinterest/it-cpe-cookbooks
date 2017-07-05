#
# Cookbook Name:: cpe_desktopwallpaper
# Resource:: cpe_desktopwallpaper
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_desktopwallpaper
default_action :run

dw_prefs = {}

action :run do
  dw_prefs = node['cpe_desktopwallpaper'].reject { |_k, v| v.nil? }
  return if dw_prefs.empty?
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  prefix = node['cpe_profiles']['prefix']
  node.default['cpe_profiles']["#{prefix}.desktopwallpaper"] = {
    'PayloadIdentifier' => "#{prefix}.desktopwallpaper",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => 'CEC5E19F-AEEC-45BF-96EE-CCC0FAC66157',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Desktop Wallpaper',
    'PayloadContent' => [
      {
        'PayloadType' => 'com.apple.desktop',
        'PayloadVersion' => 1,
        'PayloadIdentifier' => "#{prefix}.desktopwallpaper",
        'PayloadUUID' => '13CC19FC-5E0F-49E7-8F71-20D28C23AAF4',
        'PayloadEnabled' => true,
        'PayloadDisplayName' => 'Desktop Wallpaper',
        'locked' => true,
        'override-picture-path' =>
          node['cpe_desktopwallpaper']['OveridePicturePath'],
      },
    ],
  }
end
