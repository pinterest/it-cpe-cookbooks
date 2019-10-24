#
# Cookbook:: cpe_helloit
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

default['cpe_helloit'] = {
  'install' => false,
  'uninstall' => false,
  'profile' => true,
  'manage_la' => true,
  'la' => {
    'keep_alive' => true,
    'program_arguments' => [
      '/Applications/Utilities/Hello IT.app/Contents/MacOS/Hello IT',
    ],
    'run_at_load' => true,
    'type' => 'agent',
  },
  'prefs' => {
    'contents' => nil, # Array of dictionaries.
  },
  'pkg' => {
    'name' => 'helloit',
    'checksum' =>
      '73d71d960218897a2b29636a171667939ff886c215a73174165f478b218ebe04',
    'receipt' => 'com.github.ygini.hello-it',
    'version' => '1.3.2',
    'pkg_name' => nil,
    'pkg_url' => nil,
  },
}
