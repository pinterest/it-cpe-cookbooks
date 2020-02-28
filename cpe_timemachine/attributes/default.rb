#
# Cookbook:: cpe_timemachine
# Attributes:: default
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright:: (c) 2018-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#

# Time Machine MC X Settings
default['cpe_timemachine']['mcx'] = {
  'AutoBackup' => nil,
  'BackupAllVolumes' => nil,
  'BackupDestURL' => nil,
  'BackupSkipSys' => nil,
  'BackupSizeMB' => nil,
  'MobileBackups' => nil,
}

# Time Machine Standard Settings
default['cpe_timemachine']['std'] = {
  'AlwaysShowDeletedBackupsWarning' => nil,
  'AutoBackup' => nil,
  'DoNotOfferNewDisksForBackup' => nil,
  'ExcludeByPath' => nil,
  'MaxSize' => nil,
  'RequiresACPower' => nil,
  'SkipPaths' => nil,
  'SkipSystemFiles' => nil,
}
