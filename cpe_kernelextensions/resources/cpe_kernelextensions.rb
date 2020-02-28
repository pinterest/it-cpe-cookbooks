#
# Cookbook:: cpe_kernelextensions
# Resources:: cpe_kernelextensions
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2018-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_kernelextensions
default_action :run

action :run do
  ke_prefs = node['cpe_kernelextensions'].reject { |_k, v| v.nil? }
  if ke_prefs.empty?
    Chef::Log.info("#{cookbook_name}: No prefs found.")
    return
  end

  prefix = node['cpe_profiles']['prefix']
  organization = node['organization'] ? node['organization'] : 'Pinterest'
  ke_profile = {
    'PayloadIdentifier' => "#{prefix}.kernelextensions",
    'PayloadRemovalDisallowed' => true,
    'PayloadScope' => 'System',
    'PayloadType' => 'Configuration',
    'PayloadUUID' => 'C9CC8508-B976-47C8-92AD-706C5226B6A3',
    'PayloadOrganization' => organization,
    'PayloadVersion' => 1,
    'PayloadDisplayName' => 'Kernel Extensions',
    'PayloadContent' => [],
  }
  unless ke_prefs.empty?
    ke_profile['PayloadContent'].push(
      'PayloadType' => 'com.apple.syspolicy.kernel-extension-policy',
      'PayloadVersion' => 1,
      'PayloadIdentifier' => "#{prefix}.kernelextensions",
      'PayloadUUID' => '10300634-C1FB-476F-B0FA-981F9F879DCC',
      'PayloadEnabled' => true,
      'PayloadDisplayName' => 'Kernel Extensions',
    )
    ke_prefs.each_key do |key|
      next if ke_prefs[key].nil?
      ke_profile['PayloadContent'][0][key] = ke_prefs[key]
    end
  end

  node.default['cpe_profiles']["#{prefix}.kernelextensions"] = ke_profile
end
