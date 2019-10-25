#
# Cookbook:: cpe_softwareupdate
# Attributes:: default
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

default['cpe_softwareupdate'] = {
  # Commerce
  'commerce' => {
    'AutoUpdate' => nil,
    'AutoUpdateRestartRequired' => nil,
  },
  # Store Agent
  'stagent' => {
    'AutoUpdate' => nil,
  },
  # SoftwareUpdate
  'su' => {
    'AllowPreReleaseInstallation' => nil,
    'AutomaticallyInstallMacOSUpdates' => nil,
    'AutomaticCheckEnabled' => nil,
    'AutomaticDownload' => nil,
    'CatalogURL' => nil,
    'ConfigDataInstall' => nil,
    'CriticalUpdateInstall' => nil,
    'SUDisableEVCheck' => nil,
  },
}
