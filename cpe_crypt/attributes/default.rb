#
# Cookbook Name:: cpe_crypt
# Attributes:: default
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2017-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

default['cpe_crypt'] = {
  'install' => false,
  'uninstall' => false,
  'profile' => true,
  'manage_authdb' => true,
  'manage_ld' => true,
  'ld' => {
    'program_arguments' => ['/Library/Crypt/checkin'],
    'disabled' => false,
    'run_at_load' => true,
    'start_interval' => 120,
    'type' => 'daemon',
  },
  'prefs' => {
    # The ServerURL preference sets your Crypt Server. Crypt will not enforce
    # FileVault if this preference isn't set. EX: "https://crypt.example.com"
    'ServerURL' => nil, # String
    # The SkipUsers preference allows you to define an array of users that will
    # not be forced to enable FileVault. ['adminuser', 'mikedodge04']
    'SkipUsers' => nil, # Array
    # By default, the plist with the FileVault Key will be removed once it has
    # been escrowed. In a future version of Crypt, there will be the
    # possibility of verifying the escrowed key with the client. In preparation
    # for this feature, you can now choose to leave the key on disk. bool
    'RemovePlist' => nil, # Bool
    # Crypt2 can rotate the recovery key, if the key is used to unlock the disk.
    # There is a small caveat that this feature only works if the key is still
    # present on the disk. This is set to TRUE by default.
    'RotateUsedKey' => nil, # Bool
    # Crypt2 can validate the recovery key if it is stored on disk. If the key
    # fails validation, the plist is removed so it can be regenerated on next
    # login. This is set to TRUE by default.
    'ValidateKey' => nil, # Bool
    # Crypt 2 can optionally add new users to be able to unlock FileVault 2
    # volumes (when the disk is unlocked). This feature works up until macOS
    # 10.12. The default for this is FALSE.
    'FDEAddUser' => nil, # Bool
    # As of version 2.3.0 you can now define a new location for where the
    # recovery key is written to. Default for this is
    # '/var/root/crypt_output.plist'.
    'OutputPath' => nil, # Srting
    # As of version 2.3.0 you can now define the time interval in Hours for how
    # often Crypt tries to re-escrow the key, after the first successful escrow.
    # Default for this is 1 hour.
    'KeyEscrowInterval' => nil, # int
  },
  'pkg' => {
    'name' => 'crypt',
    'checksum' =>
      '1582e974820a5b27cfe462521cb0d4802319224753f3d6417ee23fff9333872a',
    'receipt' => 'com.grahamgilbert.crypt',
    'version' => '3.0.0.109',
    'pkg_name' => nil,
    'pkg_url' => nil,
  },
}
