#
# Cookbook:: cpe_8021x
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

# Ethernet Settings
default['cpe_8021x']['ethernet'] = {
  'AutoJoin' => nil,
}

# Debug Settings
default['cpe_8021x']['debug'] = {
  'PrintPlist' => nil,
}

# Wireless Settings
default['cpe_8021x']['wifi'] = {
  'AutoJoin' => nil,
}
