#
# Cookbook:: cpe_crypt
# Resources:: cpe_crypt_authdb
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_crypt_authdb
provides :cpe_crypt_authdb, :os => 'darwin'
default_action :manage

action :manage do
  return unless manage_authdb?
  # If Crypt hasn't been installed don't configure the auth db
  unless crypt_installed? || uninstall?
    Chef::Log.warn('Crypt binary not installed!')
    return
  end
  # First, validate whether or not the current settings are correct
  # Get current settings from authdb
  if crypt_currently_in_authdb && !uninstall?
    Chef::Log.debug('Authdb already configured for Crypt')
    return
  end
  manage_crypt_authorizationdb
end

action_class do
  def crypt_mechanisms
    [
      'Crypt:Check,privileged',
      'Crypt:CryptGUI',
      'Crypt:Enablement,privileged',
    ].freeze
  end

  def install?
    node['cpe_crypt']['install']
  end

  def manage?
    node['cpe_crypt']['manage_authdb']
  end

  def uninstall?
    node['cpe_crypt']['uninstall']
  end

  def manage_authdb?
    if uninstall?
      return true
    end
    if install? && manage?
      return true
    end
    false
  end

  def authdb
    current_authdb = Mixlib::ShellOut.new(
      '/usr/bin/security authorizationdb read system.login.console',
    ).run_command.stdout
    Plist.parse_xml(current_authdb)
  end

  def crypt_currently_in_authdb
    authdb_hash = authdb
    if authdb_hash.nil?
      Chef::Log.warn('Security authorization db contained no value!')
      return false
    end
    # Crypt settings
    correct_mechanisms = Set.new(['loginwindow:done'] + crypt_mechanisms)
    existing_mechanisms = Set.new(authdb_hash['mechanisms'])
    # Return true if Crypt is present in the authdb settings
    correct_mechanisms.subset?(existing_mechanisms)
  end

  def manage_crypt_authorizationdb
    authdb_hash = authdb
    # Remove any existing Crypt configs from system.login.console parse
    fixed_mechs =
      authdb_hash['mechanisms'].reject { |e| crypt_mechanisms.include? e }
    unless uninstall?
      # Add the new Crypt mechanisms back into the authdb hash
      # These must go *AFTER* "loginwindow:done"
      crypt_index = fixed_mechs.index('loginwindow:done')
      fixed_mechs.insert(crypt_index + 1, crypt_mechanisms).flatten!
    end
    authdb_hash['mechanisms'] = fixed_mechs
    # Write settings back to disk
    # Send it back to security authorizationdb
    cmd = "echo \"#{Plist::Emit.dump(authdb_hash)}\" " +
          '| /usr/bin/security authorizationdb write system.login.console'
    execute 'security_authorizationdb_write' do
      command cmd
    end
  end

  def crypt_installed?
    crypt_path =
      '/Library/Security/SecurityAgentPlugins/Crypt.bundle/Contents/MacOS/Crypt'
    ::File.exist?(crypt_path)
  end
end
