#
# Cookbook Name:: cpe_ard
# Resource:: cpe_ard
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_ard
provides :cpe_ard, :platform => 'mac_os_x'
default_action :manage

action :manage do
  manage_profile
  kickstart if node['cpe_ard']['kickstart']['manage']
end

action_class do # rubocop:disable Metrics/BlockLength
  def manage_profile
    ard_prefs = node['cpe_ard']['profile']['prefs'].reject { |_k, v| v.nil? }
    if ard_prefs.empty?
      Chef::Log.info("#{cookbook_name}: No prefs found - skipping profile "\
        'enforcement')
      return
    end

    prefix = node['cpe_profiles']['prefix']
    # rubocop:disable Style/UnneededCondition
    organization = node['organization'] ? node['organization'] : 'Pinterest'
    # rubocop:enable Style/UnneededCondition
    ard_profile = {
      'PayloadIdentifier' => "#{prefix}.ardapp",
      'PayloadRemovalDisallowed' => true,
      'PayloadScope' => 'System',
      'PayloadType' => 'Configuration',
      'PayloadUUID' => '2CAB3C80-54C4-4D61-A142-52C2EBB0DA8C',
      'PayloadOrganization' => organization,
      'PayloadVersion' => 1,
      'PayloadDisplayName' => 'Apple Remote Desktop Application',
      'PayloadContent' => [],
    }
    unless ard_prefs.empty?
      ard_profile['PayloadContent'].push(
        'PayloadType' => 'com.apple.RemoteManagement',
        'PayloadVersion' => 1,
        'PayloadIdentifier' => "#{prefix}.ardapp",
        'PayloadUUID' => '149EAD29-D27D-4639-8E8D-D8513B18A2B5',
        'PayloadEnabled' => true,
        'PayloadDisplayName' => 'Apple Remote Desktop Application',
      )
      ard_prefs.each_key do |key|
        next if ard_prefs[key].nil?
        ard_profile['PayloadContent'][0][key] = ard_prefs[key]
      end
    end

    node.default['cpe_profiles']["#{prefix}.ard"] = ard_profile
  end

  def kickstart
    if node['cpe_ard']['kickstart']['enable']
      enable
    else
      disable
    end
  end

  def disable
    # Disable ARD
    execute 'Disable Apple Remote Desktop' do
      command '/System/Library/CoreServices/RemoteManagement/ARDAgent.app/'\
      'Contents/Resources/kickstart -deactivate -configure -access -off'
      only_if { ard_server_running? }
    end
  end

  def enable
    # Enable ARD
    # If running 10.14 and higher, we need a TCC profile installed with the
    # appropriate configuration.
    if node.os_at_least?('10.14')
      tcc_profile_identifier = node['cpe_ard']['kickstart']['tcc_profile_id']
      if tcc_profile_identifier.nil? || tcc_profile_identifier.empty?
        # Bail if the attribute isn't set, or the command will fail.
        Chef::Log.warn("#{cookbook_name}: Device is running 10.14 or higher "\
          'and does not have necessary TCC profile chef attribute.')
        return
      else
        # Bail if the profile doesn't exist with the correct configuration.
        # https://support.apple.com/en-us/HT209161
        unless node.profile_contains_content?(
          'identifier \"com.apple.screensharing.agent\" and anchor apple',
          tcc_profile_identifier,
        )
          Chef::Log.warn("#{cookbook_name}: Device is running 10.14 or higher "\
            'and does not have necessary TCC profile installed with '\
            'configuration for screensharing agent.')
          return
        end
      end
    end
    execute 'Enable Apple Remote Desktop' do
      command '/System/Library/CoreServices/RemoteManagement/ARDAgent.app'\
      '/Contents/Resources/kickstart -activate -configure -allowAccessFor '\
      '-allUsers -privs -all -clientopts -setmenuextra -menuextra no -restart '\
      '-agent'
      not_if { ard_server_running? }
    end
  end

  def ard_server_running?
    # There are only two methods documented online on how to check if ARD is
    # running.
    # 1. Using launchctl list as the currently logged in user
    # 2. Various methods around grep | awk.
    # Pgrep (while not ideal) allows us to remove the awk and grep. With newer
    # versions of macOS, if we used launchctl we would have to do launchctl
    # asuser UID launchctl list. This could also fail due to users not being
    # logged in. This function allows it to work even at the loginwindow, since
    # kickstart itself does not need this dependency to kickstart.
    # Exit status of zero means it's on, exit 1 means it's off.
    shell_out(
      '/usr/bin/pgrep -f /System/Library/CoreServices/RemoteManagement/'\
        'ARDAgent.app/Contents/MacOS/ARDAgent',
    ).exitstatus.zero?
  end
end
