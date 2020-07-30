#
# Cookbook:: cpe_helloit
# Resources:: cpe_helloit_install
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

resource_name :cpe_helloit_install
provides :cpe_helloit_install, :os => 'darwin'

default_action :manage

action :manage do
  validate_install
  install if install? && !uninstall?
  remove if uninstall?
end

action_class do
  def install?
    node['cpe_helloit']['install']
  end

  def uninstall?
    node['cpe_helloit']['uninstall']
  end

  def forget_helloit_pkg # Forget the helloit package receipt
    pkg = node['cpe_helloit']['pkg']
    execute "/usr/sbin/pkgutil --forget #{pkg['receipt']}" do
      not_if do
        shell_out("/usr/sbin/pkgutil --pkg-info #{pkg['receipt']}").error?
      end
      action :run
    end
  end

  def helloit_installed?
    helloit_path =
      '/Applications/Utilities/Hello IT.app/Contents/MacOS/Hello IT'
    ::File.exist?(helloit_path)
  end

  def validate_install
    forget_helloit_pkg if install? && !helloit_installed?
  end

  def install
    pkg = node['cpe_helloit']['pkg']
    # Install Hello-IT
    cpe_remote_pkg 'helloit' do
      version pkg['version']
      checksum pkg['checksum']
      receipt pkg['receipt']
      pkg_name pkg['pkg_name'] if pkg['pkg_name']
      pkg_url pkg['pkg_url'] if pkg['pkg_url']
    end
  end

  def remove
    # Delete Hello-IT directory
    directory '/Library/Application Support/com.github.ygini.hello-it' do
      action :delete
      recursive true
    end

    # Delete default Hello-IT LaunchAgent
    launchd 'com.github.ygini.hello-it' do
      action :delete
    end

    forget_helloit_pkg
  end
end
