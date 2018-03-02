#
# Cookbook Name:: cpe_timemachine
# Attributes:: default
#
# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2
#
# Copyright (c) 2018-present, Pinterest, Inc.
# All rights reserved.
#
# This source code is licensed under the Apache 2.0 license found in the
# LICENSE file in the root directory of this source tree.
#
default['cpe_timemachine'] = {
  'AutoBackup' => nil,
  'BackupAllVolumes' => nil,
  'BackupDestURL' => nil,
  'BackupSkipSys' => nil,
  'BackupSizeMB' => nil,
  'MobileBackups' => nil,
}
