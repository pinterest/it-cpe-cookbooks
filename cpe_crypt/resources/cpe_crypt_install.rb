#
# Cookbook Name:: cpe_crypt
# Resource:: cpe_crypt_install
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_crypt_install
provides :cpe_crypt_install, :os => 'darwin'
default_action :manage

action :manage do
  validate_install
  install if install? && !uninstall?
  remove if uninstall?
end

action_class do
  def install?
    node['cpe_crypt']['install']
  end

  def uninstall?
    node['cpe_crypt']['uninstall']
  end

  def forget_crypt_pkg # Forget the crypt2 package receipt
    pkg = node['cpe_crypt']['pkg']
    execute "/usr/sbin/pkgutil --forget #{pkg['receipt']}" do
      not_if do
        shell_out("/usr/sbin/pkgutil --pkg-info #{pkg['receipt']}").error?
      end
      action :run
    end
  end

  def crypt_installed?
    crypt_path =
      '/Library/Security/SecurityAgentPlugins/Crypt.bundle/Contents/MacOS/Crypt'
    ::File.exist?(crypt_path)
  end

  def validate_install
    forget_crypt_pkg if install? && !crypt_installed?
  end

  def install
    pkg = node['cpe_crypt']['pkg']
    # Install Crypt auth plugin
    cpe_remote_pkg 'crypt' do
      version pkg['version']
      checksum pkg['checksum']
      receipt pkg['receipt']
      pkg_name pkg['pkg_name'] if pkg['pkg_name']
      pkg_url pkg['pkg_url'] if pkg['pkg_url']
    end
  end

  def remove
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

    # Delete default Crypt LaunchDaemon
    launchd 'com.grahamgilbert.crypt' do
      action :delete
    end

    forget_crypt_pkg
  end
end
