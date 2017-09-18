#
# Cookbook Name:: cpe_crypt
# Resource:: cpe_crypt_uninstall
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#
# TODO: This entire resource needs to be re-written with via the following
# method https://github.com/macadmins/puppet-authpluginmech

resource_name :cpe_crypt_uninstall
default_action :uninstall

action :uninstall do
  return unless node['cpe_crypt']['install'] == false
  # Forget the crypt2 package receipt
  receipt = node['cpe_crypt']['package']['receipt']
  cmd = "/usr/sbin/pkgutil --forget #{receipt}"
  execute 'forget crypt package' do
    command cmd
    returns [0, 1]
    only_if '/usr/sbin/pkgutil --pkgs | grep Crypt'
  end

  # Delete default Crypt LaunchDaemon
  launchd 'com.grahamgilbert.crypt' do
    action :delete
  end

  # Delete crypt directories
  [
    '/Library/Security/SecurityAgentPlugins/Crypt.bundle',
    '/Library/Crypt',
  ].each do |item|
    directory item do
      action :delete
      recursive true
    end
  end

  # First, validate whether or not the current settings are correct
  # Get current settings from authdb
  current_authdb = Mixlib::ShellOut.new(
    '/usr/bin/security authorizationdb read system.login.console',
  ).run_command.stdout
  authdb_hash = Plist.parse_xml(current_authdb)
  if authdb_hash.nil?
    Chef::Log.warn('Security authorization db contained no value!')
    return
  end
  crypt_mechanisms = [
    'Crypt:Check,privileged',
    'Crypt:CryptGUI',
    'Crypt:Enablement,privileged',
  ]
  correct_mechanisms = Set.new(['loginwindow:done'] + crypt_mechanisms)
  existing_mechanisms = Set.new(authdb_hash['mechanisms'])
  already_done = correct_mechanisms.subset?(existing_mechanisms)
  if already_done
    Chef::Log.info("#{cookbook_name}: Removing Authdb configuration for Crypt")
    # Remove existing Crypt configs from system.login.console parse
    fixed_mechs =
      authdb_hash['mechanisms'].reject { |e| crypt_mechanisms.include? e }
    # Remove the Crypt mechanisms from the authdb hash
    crypt_mechanisms.each do |del|
      fixed_mechs.delete(del)
    end
    fixed_mechs.flatten!
    authdb_hash['mechanisms'] = fixed_mechs
    # Send it back to security authorizationdb
    cmd = "echo \"#{Plist::Emit.dump(authdb_hash)}\" " +
          '| /usr/bin/security authorizationdb write system.login.console'
    execute 'security_authorizationdb_write' do
      command cmd
    end
  end
end
