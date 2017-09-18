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

default['cpe_crypt']['install'] = false

default['cpe_crypt']['preferences'] = {
  'RemovePlist' => nil,
  'RotateUsedKey' => nil,
  'ServerURL' => nil,
  'SkipUsers' => nil,
}

default['cpe_crypt']['package'] = {
  'app' => 'crypt',
  'checksum' =>
    '1582e974820a5b27cfe462521cb0d4802319224753f3d6417ee23fff9333872a',
  'receipt' => 'com.grahamgilbert.Crypt',
  'version' => '3.0.0.109',
}
